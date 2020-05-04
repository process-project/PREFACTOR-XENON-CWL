#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: genericpipeline.py
#baseCommand: echo

stdout: tarcal.txt

inputs:
  pipecfg: string
  parset: string

arguments: ["-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running tarcal===\ntarcal successfully done\ntarcal completed."]

outputs:
  out_file2:
    type: File
    streamable: true
    outputBinding:
      glob: tarcal.txt
