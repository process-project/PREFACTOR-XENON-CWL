#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: singularity
#baseCommand: echo

stdout: initsub.txt

inputs:
  pipecfg: string
  parset: string
  cimage: string
  binddir: string

arguments: ["exec", "-B", "$(inputs.binddir)", "$(inputs.cimage)", "genericpipeline.py", "-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running initsub===\ninitsub successfully done\ninitsub completed."]

outputs:
  out_file3:
    type: File
    streamable: true
    outputBinding:
      glob: initsub.txt

