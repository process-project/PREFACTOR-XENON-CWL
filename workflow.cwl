#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs: []

outputs:
  status:
    type: string
    outputSource: parse/res

steps:
  container:
    run: container.cwl
    in: []
    out: [output_file]

  parse:
    run: parse.cwl
    in:
      container_out: container/output_file
    out: [res]
