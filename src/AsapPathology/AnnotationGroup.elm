module AsapPathology.AnnotationGroup exposing (color, name, partOfGroup, setColor, setName, setPartOfGroup)

import AsapPathology.Internal.AsapPathology exposing (Annotation)
import Color exposing (Color)


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
