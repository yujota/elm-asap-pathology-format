module AsapPathology exposing
    ( AsapPathology, Annotation, AnnotationGroup
    , asapPathology
    , annotations, setAnnotations, annotationGroups, setAnnotationGroups
    )

{-| This module provides types related to ASAP XML format.


# Types

@docs AsapPathology, Annotation, AnnotationGroup


# Constructor

@docs asapPathology


# Getters & Setters

@docs annotations, setAnnotations, annotationGroups, setAnnotationGroups

-}

import AsapPathology.Internal.AsapPathology as A


{-| Represents ASAP data.
-}
type alias AsapPathology =
    A.AsapPathology


{-| Represents annotation. Corresponding to `<ASAP_Annotations><Annotations><Annotation>`.
`AsapPathology.Annotation` provides several setters and getters for it.
-}
type alias Annotation =
    A.Annotation


{-| Represents annotation group. Corresponding to `<ASAP_Annotations><AnnotationGroups><AnnotationGroup>`.
`AsapPathology.AnnotationGroup` provides several setters and getters for it.
-}
type alias AnnotationGroup =
    A.AnnotationGroup


{-| Constructor.
-}
asapPathology : { annotations : List Annotation, annotationGroups : List AnnotationGroup } -> AsapPathology
asapPathology r =
    A.AsapPathology r


{-| Getter for annotations.
-}
annotations : AsapPathology -> List Annotation
annotations (A.AsapPathology a) =
    a.annotations


{-| Setter for annotations.
-}
setAnnotations : List Annotation -> AsapPathology -> AsapPathology
setAnnotations ants (A.AsapPathology a) =
    A.AsapPathology { a | annotations = ants }


{-| Getter for annotations groups.
-}
annotationGroups : AsapPathology -> List AnnotationGroup
annotationGroups (A.AsapPathology a) =
    a.annotationGroups


{-| Setter for annotations groups.
-}
setAnnotationGroups : List AnnotationGroup -> AsapPathology -> AsapPathology
setAnnotationGroups gs (A.AsapPathology a) =
    A.AsapPathology { a | annotationGroups = gs }
