#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash
#baseCommand: echo

stdout: fac.txt

inputs:
  wpath: string
  parset: string
  cimage: string
  shared: string

outputs:
  all_done:
    type: File
    streamable: true
    outputBinding:
      glob: fac.txt

arguments:
  - prefix: -c
    valueFrom: |
      ${
        var cr = "mkdir -p ";
        var dp = inputs["wpath"].concat("/factor");
        var cd = " && cd "
        var rc = ' && singularity exec -B inputs["shared"] inputs["cimage"] runfactor -v  inputs["parset"]'
        var res = cr.concat(dp, cd, dp, rc)
        return res;
      }



