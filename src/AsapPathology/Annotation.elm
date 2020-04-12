module AsapPathology.Annotation exposing (name, setName)

import AsapPathology.Internal.AsapPathology as A exposing (Annotation)
import Color exposing (Color)


type alias AnnotationType =
    A.AnnotationType


type alias Coordinate =
    { order : Int, x : Float, y : Float }


dot : { name : String, partOfGroup : String, color : Color, x : Float, y : Float } -> Annotation
dot r =
    Annotation
        { name = r.name
        , annotationType = A.Dot
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = [ { x = r.x, y = r.y, order = 0 } ]
        }


isDot : Annotation -> Bool
isDot (Annotation a) =
    case a.annotationType of
        A.Dot ->
            True

        _ ->
            False


rectangle :
    { name : String
    , partOfGroup : String
    , color : Color
    , x0 : Float
    , y0 : Float
    , x1 : Float
    , y1 : Float
    , x2 : Float
    , y2 : Float
    , x3 : Float
    , y3 : Float
    }
    -> Annotation
rectangle r =
    Annotation
        { name = r.name
        , annotationType = A.Rectangle
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates =
            [ { x = r.x0, y = r.y0, order = 0 }
            , { x = r.x1, y = r.y1, order = 1 }
            , { x = r.x2, y = r.y2, order = 2 }
            , { x = r.x3, y = r.y3, order = 3 }
            ]
        }


isRectangle : Annotation -> Bool
isRectangle (Annotation a) =
    case a.annotationType of
        A.Rectangle ->
            True

        _ ->
            False


polygon : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
polygon r =
    Annotation
        { name = r.name
        , annotationType = A.Polygon
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


isPolygon : Annotation -> Bool
isPolygon (Annotation a) =
    case a.annotationType of
        A.Polygon ->
            True

        _ ->
            False


spline : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
spline r =
    Annotation
        { name = r.name
        , annotationType = A.Spline
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


isSpline : Annotation -> Bool
isSpline (Annotation a) =
    case a.annotationType of
        A.Spline ->
            True

        _ ->
            False


pointSet : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
pointSet r =
    Annotation
        { name = r.name
        , annotationType = A.PointSet
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


isPointSet : Annotation -> Bool
isPointSet (Annotation a) =
    case a.annotationType of
        A.PointSet ->
            True

        _ ->
            False


name : Annotation -> String
name (Annotation a) =
    a.name


setName : String -> Annotation -> Annotation
setName n (Annotation a) =
    Annotation { a | name = n }


partOfGroup : Annotation -> String
partOfGroup (Annotation a) =
    a.partOfGroup


setPartOfGroup : String -> Annotation -> Annotation
setPartOfGroup p (Annotation a) =
    Annotation { a | partOfGroup = p }


color : Annotation -> Color
color (Annotation a) =
    a.color


setColor : Color -> Annotation -> Annotation
setColor c (Annotation a) =
    Annotation { a | color = c }


coordinates : Annotation -> List { order : Int, x : Float, y : Float }
coordinates (Annotation a) =
    a.coordinates


setCoordinates : List { order : Int, x : Float, y : Float } -> Annotation -> Annotation
setCoordinates cs (Annotation a) =
    Annotation { a | coordinates = cs }
