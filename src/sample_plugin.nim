import jester

type
    Sample* = object
        name*: string

proc newSamplePlugin*(req: Request, res: ResponseData, name: string): Sample =
    ## Creates a jester plugin for testing out crap.
    result.name = name

proc newSamplePlugin_after*(req: Request, res: ResponseData, sample: Sample) =
    discard

proc sayHello*(sample: Sample): string =
    ## Say hello to the sample plugin!
    ## - sample: something
    "Hello " & sample.name
