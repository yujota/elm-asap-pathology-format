module AsapPathology.AnnotationGroup exposing (color, name, partOfGroup, setColor, setName, setPartOfGroup)

import AsapPathology.Internal.AsapPathology as A
import Color exposing (Color)


type alias AnnotationGroup =
    A.AnnotationGroup


name : AnnotationGroup -> String
name (A.AnnotationGroup a) =
    a.name


setName : String -> AnnotationGroup -> AnnotationGroup
setName n (A.AnnotationGroup a) =
    A.AnnotationGroup { a | name = n }


partOfGroup : AnnotationGroup -> String
partOfGroup (A.AnnotationGroup a) =
    a.partOfGroup


setPartOfGroup : String -> AnnotationGroup -> AnnotationGroup
setPartOfGroup p (A.AnnotationGroup a) =
    A.AnnotationGroup { a | partOfGroup = p }


color : AnnotationGroup -> Color
color (A.AnnotationGroup a) =
    a.color


setColor : Color -> AnnotationGroup -> AnnotationGroup
setColor c (A.AnnotationGroup a) =
    A.AnnotationGroup { a | color = c }
