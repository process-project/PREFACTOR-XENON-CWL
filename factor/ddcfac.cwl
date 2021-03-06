#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash
#baseCommand: echo

stdout: fac.txt

inputs:
  factordir: string
  parset: string
  cimage: string
  binddir: string

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
        var bdd = inputs["binddir"].concat(" ")
        var img = inputs["cimage"].concat(" ")
        var pst = inputs["parset"]
        var sgp = " && singularity exec -B "
        var rc = sgp.concat(bdd, img, "runfactor -v ", pst)
        var res = cr.concat(dp, cd, dp, rc)
        return res;
      }


