module AsapPathology.Decode exposing (decodeString)

{-| Decoder for ASAP XML format.


# Decoder

@docs decodeString

-}

import AsapPathology.Internal.AsapPathology as A exposing (AsapPathology)
import Color exposing (Color)
import Color.Convert
import Xml.Decode as XD


{-| Decode ASAP XML format to `AsapPathology`.

    xmlString =
        """
        <?xml version="1.0"?>
        <ASAP_Annotations>
            <Annotations>
                <Annotation Name="Annotation 0" Type="Dot" PartOfGroup="None" Color="#FFFFFF">
                    <Coordinates>
                        <Coordinate Order="0" X="100" Y="200" />
                    </Coordinates>
                </Annotation>
            </Annotations>
            <AnnotationGroups></AnnotationGroups>
        </ASAP_Annotations>
        """

    decoded = decodeString xmlString
    Result.map AsapPathology.annotations decoded
        == Ok [ Annotation.dot { name = "Sample", partOfGroup = "None", color = Color.white, x = 100, y = 200 } ]

-}
decodeString : String -> Result String AsapPathology
decodeString =
    XD.decodeString asapPathologyDecoder


asapPathologyDecoder : XD.Decoder AsapPathology
asapPathologyDecoder =
    XD.succeed A.AsapPathologyRecord
        |> XD.requiredPath [ "Annotations", "Annotation" ] (XD.list annotationDecoder)
        |> XD.requiredPath [ "AnnotationGroups", "Group" ] (XD.list groupDecoder)
        |> XD.map A.AsapPathology


annotationDecoder : XD.Decoder A.Annotation
annotationDecoder =
    XD.map5 A.AnnotationRecord
        (XD.stringAttr "Name")
        (XD.stringAttr "Type" |> decodeAnnotationType)
        (XD.stringAttr "PartOfGroup")
        (XD.stringAttr "Color" |> decodeColor)
        (XD.path [ "Coordinates", "Coordinate" ] (XD.list coordinateDecoder))
        |> XD.map A.Annotation


coordinateDecoder : XD.Decoder A.Coordinate
coordinateDecoder =
    XD.map3 A.Coordinate
        (XD.intAttr "Order")
        (XD.floatAttr "X")
        (XD.floatAttr "Y")


groupDecoder : XD.Decoder A.AnnotationGroup
groupDecoder =
    XD.map3 A.AnnotationGroupRecord
        (XD.stringAttr "Name")
        (XD.stringAttr "PartOfGroup")
        (XD.stringAttr "Color" |> decodeColor)
        |> XD.map A.AnnotationGroup


decodeColor : XD.Decoder String -> XD.Decoder Color
decodeColor =
    XD.andThen
        (\s ->
            case Color.Convert.hexToColor s of
                Ok c ->
                    XD.succeed c

                Err errMsg ->
                    XD.fail errMsg
        )


decodeAnnotationType : XD.Decoder String -> XD.Decoder A.AnnotationType
decodeAnnotationType =
    XD.andThen
        (\s ->
            case A.stringToType s of
                Just aType ->
                    XD.succeed aType

                Nothing ->
                    XD.fail "Invalid annotation type is detected!"
        )
