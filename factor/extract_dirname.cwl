#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: [bash, -c, "tars=(/var/scratch/madougou/LOFAR/*.tar);echo -n \"`basename ${tars[0]}`\" | awk -F'_' '{print $1}'"]

stdout: out.txt

inputs: []

outputs:
  ms_dirname: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents.trim())