#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash

stdout: out.txt

inputs:
  ms_dirname:
    type: string

outputs:
  ms_done:
    type: File
    streamable: true
    outputBinding:
      glob: out.txt

arguments:
  - prefix: -c
    valueFrom: |
      ${
        var cr = "mkdir -p ";
        var dp = "/var/scratch/madougou/LOFAR/PROCESS/".concat(inputs["ms_dirname"]);
        var lc = " && for file in /var/scratch/madougou/LOFAR/*.tar; do tar xf \"$file\" -C "
        var rc = " && rm \"$file\"; done"
        var res = cr.concat(dp, lc, dp, rc)
        return res;
      }


