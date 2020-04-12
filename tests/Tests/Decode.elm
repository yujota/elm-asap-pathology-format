module Tests.Decode exposing (..)

import Array exposing (Array)
import AsapPathology.Decode as AD
import AsapPathology.Internal.AsapPathology as A
import Expect exposing (equal)
import Test exposing (Test, describe, test)


decodeString : Test
decodeString =
    let
        decodedAnnotations =
            AD.decodeString sampleXml
                |> Result.map (\(A.AsapPathology a) -> Array.fromList a.annotations)

        getAnnotation i =
            Result.andThen (Array.get i >> Result.fromMaybe "failed") decodedAnnotations

        checkDotAnnotation () =
            let
                actual =
                    getAnnotation 0

                desired =
                    Ok
                        (A.Annotation
                            { name = "Annotation 0"
                            , annotationType = A.Dot
                            , partOfGroup = "None"
                            , color = "#F4FA58"
                            , coordinates = [ { order = 0, x = 1173.36755, y = 766.442078 } ]
                            }
                        )
            in
            equal actual desired

        checkPolygonAnnotation () =
            let
                actual =
                    getAnnotation 1

                desired =
                    Ok
                        (A.Annotation
                            { name = "Annotation 1"
                            , annotationType = A.Polygon
                            , partOfGroup = "None"
                            , color = "#F4FA58"
                            , coordinates =
                                [ { order = 0, x = 659.772278, y = 1406.46069 }
                                , { order = 1, x = 738.786926, y = 1552.63782 }
                                , { order = 2, x = 829.653809, y = 1726.47009 }
                                , { order = 3, x = 916.569885, y = 1872.64709 }
                                , { order = 4, x = 1039.0426, y = 2026.72571 }
                                ]
                            }
                        )
            in
            equal actual desired

        checkSplineAnnotation () =
            let
                actual =
                    getAnnotation 2
                        |> Result.map (\(A.Annotation a) -> a.annotationType)

                desired =
                    Ok A.Spline
            in
            equal actual desired

        checkPointSetAnnotation () =
            let
                actual =
                    getAnnotation 3
                        |> Result.map (\(A.Annotation a) -> a.annotationType)

                desired =
                    Ok A.PointSet
            in
            equal actual desired

        checkRectangleAnnotation () =
            let
                actual =
                    getAnnotation 4
                        |> Result.map (\(A.Annotation a) -> a.annotationType)

                desired =
                    Ok A.Rectangle
            in
            equal actual desired
    in
    describe "test PascalVoc.Decode.decodeString"
        [ test "test dot annotation" checkDotAnnotation
        , test "test polygon annotation" checkPolygonAnnotation
        , test "test spline annotation" checkSplineAnnotation
        , test "test point set annotation" checkPointSetAnnotation
        , test "test rectangle annotation" checkRectangleAnnotation
        ]


sampleXml : String
sampleXml =
    """
    <?xml version="1.0"?>
    <ASAP_Annotations>
    \t<Annotations>
    \t\t<Annotation Name="Annotation 0" Type="Dot" PartOfGroup="None" Color="#F4FA58">
    \t\t\t<Coordinates>
    \t\t\t\t<Coordinate Order="0" X="1173.36755" Y="766.442078" />
    \t\t\t</Coordinates>
    \t\t</Annotation>
    \t\t<Annotation Name="Annotation 1" Type="Polygon" PartOfGroup="None" Color="#F4FA58">
    \t\t\t<Coordinates>
    \t\t\t\t<Coordinate Order="0" X="659.772278" Y="1406.46069" />
    \t\t\t\t<Coordinate Order="1" X="738.786926" Y="1552.63782" />
    \t\t\t\t<Coordinate Order="2" X="829.653809" Y="1726.47009" />
    \t\t\t\t<Coordinate Order="3" X="916.569885" Y="1872.64709" />
    \t\t\t\t<Coordinate Order="4" X="1039.0426" Y="2026.72571" />
    \t\t\t</Coordinates>
    \t\t</Annotation>
    \t\t<Annotation Name="Annotation 2" Type="Spline" PartOfGroup="None" Color="#F4FA58">
    \t\t\t<Coordinates>
    \t\t\t\t<Coordinate Order="0" X="430.629822" Y="1983.2677" />
    \t\t\t\t<Coordinate Order="1" X="454.334229" Y="2168.95215" />
    \t\t\t\t<Coordinate Order="2" X="493.841553" Y="2390.19312" />
    \t\t\t\t<Coordinate Order="3" X="624.215698" Y="2532.41943" />
    \t\t\t\t<Coordinate Order="4" X="782.244995" Y="2492.91211" />
    \t\t\t</Coordinates>
    \t\t</Annotation>
    \t\t<Annotation Name="Annotation 3" Type="PointSet" PartOfGroup="None" Color="#F4FA58">
    \t\t\t<Coordinates>
    \t\t\t\t<Coordinate Order="0" X="209.388809" Y="466.186432" />
    \t\t\t\t<Coordinate Order="1" X="308.157135" Y="659.772278" />
    \t\t\t</Coordinates>
    \t\t</Annotation>
    \t\t<Annotation Name="Annotation 4" Type="Rectangle" PartOfGroup="None" Color="#F4FA58">
    \t\t\t<Coordinates>
    \t\t\t\t<Coordinate Order="0" X="51.3595276" Y="1363.00256" />
    \t\t\t\t<Coordinate Order="1" X="391.122498" Y="1363.00256" />
    \t\t\t\t<Coordinate Order="2" X="391.122498" Y="1647.45532" />
    \t\t\t\t<Coordinate Order="3" X="51.3595276" Y="1647.45532" />
    \t\t\t</Coordinates>
    \t\t</Annotation>
    \t</Annotations>
    \t<AnnotationGroups>
    \t\t<Group Name="Annotation Group 0" PartOfGroup="None" Color="#64FE2E">
    \t\t\t<Attributes />
    \t\t</Group>
    \t</AnnotationGroups>
    </ASAP_Annotations>
    """
