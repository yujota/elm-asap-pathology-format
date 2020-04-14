module AsapPathology.Annotation exposing
    ( Coordinate
    , dot, rectangle, polygon, spline, pointSet
    , name, setName, partOfGroup, setPartOfGroup, color, setColor, coordinates, setCoordinates
    , isDot, isRectangle, isPolygon, isSpline, isPointSet, typeAsString
    )

{-| This module provides getters and setters for `Annotation`.


# Types

@docs Coordinate


# Constructor

@docs dot, rectangle, polygon, spline, pointSet


# Getters & Setters

@docs name, setName, partOfGroup, setPartOfGroup, color, setColor, coordinates, setCoordinates


# Utilities

@docs isDot, isRectangle, isPolygon, isSpline, isPointSet, typeAsString

-}

import AsapPathology.Internal.AsapPathology as A
import Color exposing (Color)


type alias Annotation =
    A.Annotation


{-| Represents a coordinate of `Annotation`.
Corresponding to `<ASAP_Annotation><Annotations><Annotation><Coordinates><Coordinate>`.
-}
type alias Coordinate =
    { order : Int, x : Float, y : Float }


{-| Create dot annotation.
-}
dot : { name : String, partOfGroup : String, color : Color, x : Float, y : Float } -> Annotation
dot r =
    A.Annotation
        { name = r.name
        , annotationType = A.Dot
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = [ { x = r.x, y = r.y, order = 0 } ]
        }


{-| Check given annotation is dot.
-}
isDot : Annotation -> Bool
isDot (A.Annotation a) =
    case a.annotationType of
        A.Dot ->
            True

        _ ->
            False


{-| Create rectangle annotation.
-}
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
    A.Annotation
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


{-| Check given annotation is rectangle.
-}
isRectangle : Annotation -> Bool
isRectangle (A.Annotation a) =
    case a.annotationType of
        A.Rectangle ->
            True

        _ ->
            False


{-| Create polygon annotation.
-}
polygon : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
polygon r =
    A.Annotation
        { name = r.name
        , annotationType = A.Polygon
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


{-| Check given annotation is polygon
-}
isPolygon : Annotation -> Bool
isPolygon (A.Annotation a) =
    case a.annotationType of
        A.Polygon ->
            True

        _ ->
            False


{-| Create spline annotation.
-}
spline : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
spline r =
    A.Annotation
        { name = r.name
        , annotationType = A.Spline
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


{-| Check given annotation is spline
-}
isSpline : Annotation -> Bool
isSpline (A.Annotation a) =
    case a.annotationType of
        A.Spline ->
            True

        _ ->
            False


{-| Create 'point set' annotation.
-}
pointSet : { name : String, partOfGroup : String, color : Color, coordinates : List Coordinate } -> Annotation
pointSet r =
    A.Annotation
        { name = r.name
        , annotationType = A.PointSet
        , partOfGroup = r.partOfGroup
        , color = r.color
        , coordinates = r.coordinates
        }


{-| Check given annotation is point set.
-}
isPointSet : Annotation -> Bool
isPointSet (A.Annotation a) =
    case a.annotationType of
        A.PointSet ->
            True

        _ ->
            False


{-| Getter for name of `Annotation`.
Corresponding to attribute `Name` of `<ASAP_Annotation><Annotations><Annotation>`
-}
name : Annotation -> String
name (A.Annotation a) =
    a.name


{-| Setter for name of `Annotation`.
-}
setName : String -> Annotation -> Annotation
setName n (A.Annotation a) =
    A.Annotation { a | name = n }


{-| Getter for 'part of group' of `Annotation`.
Corresponding to attribute `PartOfGroup` of `<ASAP_Annotation><Annotations><Annotation>`
In most cases, this value would be "None".
-}
partOfGroup : Annotation -> String
partOfGroup (A.Annotation a) =
    a.partOfGroup


{-| Setter for 'part of group' of `Annotation`.
-}
setPartOfGroup : String -> Annotation -> Annotation
setPartOfGroup p (A.Annotation a) =
    A.Annotation { a | partOfGroup = p }


{-| Getter for color of `Annotation`.
Corresponding to attribute `Color` of `<ASAP_Annotation><Annotations><Annotation>`

The type of return value is defined at avh4/elm-color

-}
color : Annotation -> Color
color (A.Annotation a) =
    a.color


{-| Setter for color of `Annotation`.
-}
setColor : Color -> Annotation -> Annotation
setColor c (A.Annotation a) =
    A.Annotation { a | color = c }


{-| Getter for coordinates of `Annotation`.
Corresponding to `<ASAP_Annotation><Annotations><Annotation><Coordinates>`
-}
coordinates : Annotation -> List { order : Int, x : Float, y : Float }
coordinates (A.Annotation a) =
    a.coordinates


{-| Setter for coordinates of `Annotation`.
-}
setCoordinates : List { order : Int, x : Float, y : Float } -> Annotation -> Annotation
setCoordinates cs (A.Annotation a) =
    A.Annotation { a | coordinates = cs }


{-| It returns annotation type as `String`
Corresponding to attribute `Type` of `<ASAP_Annotation><Annotations><Annotation>`

    dotAnnotation =
        dot { name = "Sample", partOfGroup = "None", color = Color.red, x = 100, y = 200 }
    typeAsString dotAnnotation == "Dot"

-}
typeAsString : Annotation -> String
typeAsString (A.Annotation a) =
    A.typeToString a.annotationType
