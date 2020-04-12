module AsapPathology.Decode exposing (decodeString)

import AsapPathology.Internal.AsapPathology as A exposing (AsapPathology)
import Xml.Decode as XD


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
        (XD.stringAttr "Type" |> XD.map A.string2Type)
        (XD.stringAttr "PartOfGroup")
        (XD.stringAttr "Color")
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
        (XD.stringAttr "Color")
        |> XD.map A.AnnotationGroup
