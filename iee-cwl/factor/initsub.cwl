#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool


baseCommand: genericpipeline.py
#baseCommand: echo

stdout: initsub.txt

inputs:
  pipecfg: string
  parset: string

arguments: ["-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running initsub===\ninitsub successfully done\ninitsub completed."]

outputs:
  out_file3:
    type: File
    streamable: true
    outputBinding:
      glob: initsub.txt

