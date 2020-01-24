#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: []

outputs:
  status:
    type: string
    outputSource: parse3/res

steps:
  dirname:
    run: factor/extract_dirname.cwl
    in: []
    out: [ms_dirname]

  fildir:
    run: factor/msdir_fill.cwl
    in:
      ms_dirname: dirname/ms_dirname
    out: [ms_done]

  calcal:
    run: factor/calcal.cwl
    in: 
      ms_ready: fildir/ms_done
    out: [out_file1]

  parse1:
    run: factor/parse1.cwl
    in:
      calcal_out: calcal/out_file1
    out: [res1]

  tarcal:
    run: factor/tarcal.cwl
    in: 
      out_parse1: parse1/res1
    out: [out_file2]

  parse2:
    run: factor/parse2.cwl
    in:
      tarcal_out: tarcal/out_file2
    out: [res2]

  inifac:
    run: factor/initsub.cwl
    in: 
      out_parse2: parse2/res2
    out: [out_file3]

  parse3:
    run: factor/parse3.cwl
    in:
      parse1_out: parse1/res1
      parse2_out: parse2/res2
      inifac_out: inifac/out_file3
    out: [res]
