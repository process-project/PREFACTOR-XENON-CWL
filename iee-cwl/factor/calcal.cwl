#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: genericpipeline.py
#baseCommand: echo

stdout: calcal.txt

inputs:
  pipecfg: string
  parset: string
 
arguments: ["-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running calcal===\ncalcal successfully done\nCalcal completed."]

outputs:
  out_file1:
    type: File
    streamable: true
    outputBinding:
      glob: calcal.txt
