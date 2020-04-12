module AsapPathology exposing (..)

import AsapPathology.Internal.AsapPathology as A


type alias AsapPathology =
    A.AsapPathology


type alias Annotation =
    A.Annotation


type alias AnnotationGroup =
    A.AnnotationGroup


annotations : AsapPathology -> List Annotation
annotations (A.AsapPathology a) =
    a.annotations


setAnnotations : List Annotation -> AsapPathology -> AsapPathology
setAnnotations ants (A.AsapPathology a) =
    A.AsapPathology { a | annotations = ants }


annotationGroups : AsapPathology -> List AnnotationGroup
annotationGroups (A.AsapPathology a) =
    a.annotationGroups


setAnnotationGroups : List AnnotationGroup -> AsapPathology -> AsapPathology
setAnnotationGroups gs (A.AsapPathology a) =
    A.AsapPathology { a | annotationGroups = gs }
