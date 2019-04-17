#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: []

outputs:
  status:
    type: string
    outputSource: parse3/res

steps:
  calcal:
    run: calcal.cwl
    in: []
    out: [out_file1]

  parse1:
    run: parse1.cwl
    in:
      calcal_out: calcal/out_file1
    out: [res1]

  tarcal:
    run: tarcal.cwl
    in: 
      out_parse1: parse1/res1
    out: [out_file2]

  parse2:
    run: parse2.cwl
    in:
      tarcal_out: tarcal/out_file2
    out: [res2]

  imgtar:
    run: imgtar.cwl
    in: 
      out_parse2: parse2/res2
    out: [out_file3]

  parse3:
    run: parse3.cwl
    in:
      parse1_out: parse1/res1
      parse2_out: parse2/res2
      imgtar_out: imgtar/out_file3
    out: [res]
