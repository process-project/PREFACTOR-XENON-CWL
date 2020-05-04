#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: bash

stdout: prep2run.txt

inputs:
  workdir: string

outputs:
  ready2run:
    type: File
    streamable: true
    outputBinding:
      glob: prep2run.txt

arguments:
  - prefix: -c
    valueFrom: |
      ${
        var cr = "mkdir -p ";
        var dp = inputs["workdir"].concat("/prefactor_output");
        var res = cr.concat(dp)
        return res;
      }
