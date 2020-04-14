module AsapPathology.Encode exposing (format)

{-| Encoder for ASAP XML format


# Encoder

@docs format

-}

import AsapPathology.Internal.AsapPathology as A exposing (AsapPathology)
import Color.Convert
import XmlParser as XP


{-| Encode `AsapPathology` to XML.

    data =
        AsapPathology.asapPathology { annotations = [], annotationGroups = [] }

    format data
        == """<?xml version="1.0"?><ASAP_Annotations ><Annotations ></Annotations><AnnotationGroups ></AnnotationGroups></ASAP_Annotations>"""

-}
format : AsapPathology -> String
format (A.AsapPathology r) =
    { processingInstructions = [ { name = "xml version", value = "1.0" } ]
    , docType = Nothing
    , root =
        XP.Element "ASAP_Annotations"
            []
            [ XP.Element "Annotations" [] (List.map encodeAnnotation r.annotations)
            , XP.Element "AnnotationGroups" [] (List.map encodeAnnotationGroup r.annotationGroups)
            ]
    }
        |> XP.format


encodeAnnotation : A.Annotation -> XP.Node
encodeAnnotation (A.Annotation r) =
    XP.Element "Annotation"
        [ { name = "Name", value = r.name }
        , { name = "Type", value = A.typeToString r.annotationType }
        , { name = "PartOfGroup", value = r.partOfGroup }
        , { name = "Color", value = Color.Convert.colorToHex r.color }
        ]
        [ XP.Element "Coordinates" [] (List.map encodeCoordinate r.coordinates) ]


encodeAnnotationGroup : A.AnnotationGroup -> XP.Node
encodeAnnotationGroup (A.AnnotationGroup r) =
    XP.Element "AnnotationGroup"
        [ { name = "Name", value = r.name }
        , { name = "PartOfGroup", value = r.partOfGroup }
        , { name = "Color", value = Color.Convert.colorToHex r.color }
        ]
        []


encodeCoordinate : A.Coordinate -> XP.Node
encodeCoordinate r =
    XP.Element "Coordinate"
        [ { name = "Order", value = String.fromInt r.order }
        , { name = "X", value = String.fromFloat r.x }
        , { name = "Y", value = String.fromFloat r.y }
        ]
        []
