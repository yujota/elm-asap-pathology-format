module AsapPathology.Internal.AsapPathology exposing
    ( Annotation(..)
    , AnnotationGroup(..)
    , AnnotationGroupRecord
    , AnnotationRecord
    , AnnotationType(..)
    , AsapPathology(..)
    , AsapPathologyRecord
    , Coordinate
    , stringToType
    , typeToString
    )

import Color exposing (Color)


type AsapPathology
    = AsapPathology AsapPathologyRecord


type alias AsapPathologyRecord =
    { annotations : List Annotation, annotationGroups : List AnnotationGroup }


type Annotation
    = Annotation AnnotationRecord


type alias AnnotationRecord =
    { name : String
    , annotationType : AnnotationType
    , partOfGroup : String
    , color : Color
    , coordinates : List Coordinate
    }


type AnnotationType
    = Dot
    | Rectangle
    | Polygon
    | Spline
    | PointSet


type alias Coordinate =
    { order : Int, x : Float, y : Float }


type AnnotationGroup
    = AnnotationGroup AnnotationGroupRecord


type alias AnnotationGroupRecord =
    { name : String
    , partOfGroup : String
    , color : Color
    }


stringToType : String -> Maybe AnnotationType
stringToType str =
    if str == "Dot" then
        Just Dot

    else if str == "Rectangle" then
        Just Rectangle

    else if str == "Polygon" then
        Just Polygon

    else if str == "Spline" then
        Just Spline

    else if str == "PointSet" then
        Just PointSet

    else
        Nothing


typeToString : AnnotationType -> String
typeToString aType =
    case aType of
        Dot ->
            "Dot"

        Rectangle ->
            "Rectangle"

        Polygon ->
            "Polygon"

        Spline ->
            "Spline"

        PointSet ->
            "PointSet"
