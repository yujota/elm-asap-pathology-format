module AsapPathology.Internal.AsapPathology exposing
    ( Annotation(..)
    , AnnotationGroup(..)
    , AnnotationGroupRecord
    , AnnotationRecord
    , AnnotationType(..)
    , AsapPathology(..)
    , AsapPathologyRecord
    , Coordinate
    , string2Type
    )


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
    , color : String
    , coordinates : List Coordinate
    }


type AnnotationType
    = Dot
    | Rectangle
    | Polygon
    | Spline
    | PointSet
    | UndefinedType


type alias Coordinate =
    { order : Int, x : Float, y : Float }


type AnnotationGroup
    = AnnotationGroup AnnotationGroupRecord


type alias AnnotationGroupRecord =
    { name : String
    , partOfGroup : String
    , color : String
    }


string2Type : String -> AnnotationType
string2Type str =
    if str == "Dot" then
        Dot

    else if str == "Rectangle" then
        Rectangle

    else if str == "Polygon" then
        Polygon

    else if str == "Spline" then
        Spline

    else if str == "PointSet" then
        PointSet

    else
        UndefinedType
