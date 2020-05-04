#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash

stdout: out.txt

inputs:
  obsms: string
  datadir: string

outputs:
  ms_ok:
    type: File
    streamable: true
    outputBinding:
      glob: out.txt

arguments:
  - prefix: -c
    valueFrom: |
      ${
        var cr = "mkdir -p ";
        var indir = inputs["datadir"]
        var dp = indir.concat("/data/L", inputs["obsms"]);
        var lc = " && for file in ".concat(indir, "/L", inputs["obsms"], "*.tar; do tar xf \"$file\" -C ")
        var rc = " && rm \"$file\"; done"
        var res = cr.concat(dp, lc, dp, rc)
        return res;
      }
