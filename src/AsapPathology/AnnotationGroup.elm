module AsapPathology.AnnotationGroup exposing
    ( annotationGroup
    , name, setName, partOfGroup, setPartOfGroup, color, setColor
    )

{-| This module provides getters and setters for `Annotation`.


# Constructor

@docs annotationGroup


# Getters & Setters

@docs name, setName, partOfGroup, setPartOfGroup, color, setColor

-}

import AsapPathology.Internal.AsapPathology as A
import Color exposing (Color)


type alias AnnotationGroup =
    A.AnnotationGroup


{-| Create annotation group.
Corresponding to `<ASAP_Annotation><AnnotationGroups><AnnotationGroup>`.
-}
annotationGroup : { name : String, partOfGroup : String, color : Color } -> AnnotationGroup
annotationGroup =
    A.AnnotationGroup


{-| Getter for name of `Annotation`.
Corresponding to attribute `Name` of `<ASAP_Annotation><AnnotationGroups><AnnotationGroup>`
-}
name : AnnotationGroup -> String
name (A.AnnotationGroup a) =
    a.name


{-| Setter for name of `AnnotationGroup`.
-}
setName : String -> AnnotationGroup -> AnnotationGroup
setName n (A.AnnotationGroup a) =
    A.AnnotationGroup { a | name = n }


{-| Getter for 'part of group' of `Annotation`.
Corresponding to attribute `PartOfGroup` of `<ASAP_Annotation><AnnotationGroups><AnnotationGroup>`
In most cases, this value would be "None".
-}
partOfGroup : AnnotationGroup -> String
partOfGroup (A.AnnotationGroup a) =
    a.partOfGroup


{-| Setter for 'part of group' of `AnnotationGroup`.
-}
setPartOfGroup : String -> AnnotationGroup -> AnnotationGroup
setPartOfGroup p (A.AnnotationGroup a) =
    A.AnnotationGroup { a | partOfGroup = p }


{-| Getter for color of `AnnotationGroup`.
Corresponding to attribute `Color` of `<ASAP_Annotation><AnnotationGroups><AnnotationGroup>`

The type of return value is defined at avh4/elm-color

-}
color : AnnotationGroup -> Color
color (A.AnnotationGroup a) =
    a.color


{-| Setter for color of `AnnotationGroup`.
-}
setColor : Color -> AnnotationGroup -> AnnotationGroup
setColor c (A.AnnotationGroup a) =
    A.AnnotationGroup { a | color = c }
