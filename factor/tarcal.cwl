#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: singularity
#baseCommand: echo

stdout: tarcal.txt

inputs:
  pipecfg: string
  parset: string
  cimage: string
  binddir: string

arguments: ["exec", "-B", "$(inputs.binddir)", "$(inputs.cimage)", "genericpipeline.py", "-d", "-c", "$(inputs.pipecfg)", "$(inputs.parset)"]
#arguments: ["===Running tarcal===\ntarcal successfully done\ntarcal completed."]

outputs:
  out_file2:
    type: File
    streamable: true
    outputBinding:
      glob: tarcal.txt
