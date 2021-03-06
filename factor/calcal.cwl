#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: singularity
#baseCommand: echo

stdout: calcal.txt

inputs:
  pipecfg: string
  parset: string
  cimage: string
  binddir: string
 
arguments: ["exec", "-B", "$(inputs.binddir)", "$(inputs.cimage)", "genericpipeline.py", "-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running calcal===\ncalcal successfully done\nCalcal completed."]

outputs:
  out_file1:
    type: File
    streamable: true
    outputBinding:
      glob: calcal.txt
