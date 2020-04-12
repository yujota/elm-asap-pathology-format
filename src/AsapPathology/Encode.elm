module AsapPathology.Encode exposing (..)

import AsapPathology.Internal.AsapPathology as A exposing (AsapPathology)
import Color.Convert
import XmlParser as XP


format : AsapPathology -> String
format (A.AsapPathology r) =
    { processingInstructions = []
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
