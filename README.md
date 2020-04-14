# elm-asap-pathology-format
Elm library providing encoder/decoder for automated slide analysis platform XML format (https://github.com/computationalpathologygroup/ASAP).

**This is not an official library for ASAP.**

- [Live example](https://yujota.github.io/elm-asap-pathology-format/) 
- [Source code of live exmaple](https://github.com/yujota/elm-asap-pathology-format/blob/master/examples/Example.elm)

## How to use 

### Decode example


```elm
import AsapPathology.Annotation as Annotation
import AsapPathology.Encode exposing (decodeString)
import Color


xmlString =
    """
    <?xml version="1.0"?>
    <ASAP_Annotations>
        <Annotations>
            <Annotation Name="Annotation 0" Type="Dot" PartOfGroup="None" Color="#FFFFFF">
                <Coordinates>
                    <Coordinate Order="0" X="100" Y="200" />
                </Coordinates>
            </Annotation>
        </Annotations>
        <AnnotationGroups></AnnotationGroups>
    </ASAP_Annotations>
    """

decoded = decodeString xmlString
Result.map AsapPathology.annotations decoded
    == Ok [ Annotation.dot { name = "Sample", partOfGroup = "None", color = Color.white, x = 100, y = 200 } ]
```


### Encode example


```elm
import AsapPathology exposing (asapPathology)
import AsapPathology.Annotation as Annotation
import AsapPathology.AnnotationGroup as AnnotationGroup
import AsapPathology.Encode exposing (decodeString)
import Color

data = asapPathology 
    { annotations = [ Annotation.dot { name = "Sample", partOfGroup = "None", color = Color.white, x = 100, y = 200 } ]
    , annotationGroups = [ AnnotationGroup.annotationGroup { name = "SampleGroup", partOfGroup = "None", color = Color.orange } ]
    }
```
