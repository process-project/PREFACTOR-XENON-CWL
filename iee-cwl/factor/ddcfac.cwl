#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash

stdout: fac.txt

inputs:
  factordir: string
  parset: string

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
        var dp = inputs["factordir"];
        var cd = " && cd "
        var pst = inputs["parset"]
        var sgp = " && runfactor -v "
        var rc = sgp.concat(pst)
        var res = cr.concat(dp, cd, dp, rc)
        return res;
      }


