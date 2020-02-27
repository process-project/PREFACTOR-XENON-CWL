#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: 
  obs: string
  cfg_src: string
  pf_out: string
  prefactor: string
  workdir: string
  datadir: string
  container: string
  binddir: string
  fac_src: string
  WMS: string

outputs:
  status:
    type: File
    outputSource: ddcfac/all_done

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

  prepcfg:
    run: factor/prepcfg.cwl
    in: 
      src: cfg_src
      outdir: pf_out
      ppath: prefactor
      wpath: workdir
      ms_ready: fildir/ms_done
    out: [cfg_fname]

  prepcal:
    run: factor/prepcal.cwl
    in: 
      obs: obs
      dpath: datadir
      ppath: prefactor
      wpath: workdir
      cfg_file: prepcfg/cfg_fname
    out: [cal_parset]

  calcal:
    run: factor/calcal.cwl
    in: 
      shared: binddir
      cimage: container
      pipecfg: prepcfg/cfg_fname
      parset: prepcal/cal_parset
    out: [out_file1]

  parse1:
    run: factor/parse1.cwl
    in:
      calcal_out: calcal/out_file1
    out: [res1]

  preptar:
    run: factor/preptar.cwl
    in: 
      obs: obs
      dpath: datadir
      ppath: prefactor
      wpath: workdir
      res1: parse1/res1
    out: [tar_parset]

  tarcal:
    run: factor/tarcal.cwl
    in: 
      shared: binddir
      cimage: container
      pipecfg: prepcfg/cfg_fname
      parset: preptar/tar_parset
    out: [out_file2]

  parse2:
    run: factor/parse2.cwl
    in:
      tarcal_out: tarcal/out_file2
    out: [res2]

  prepsub:
    run: factor/prepsub.cwl
    in: 
      obs: obs
      outdir: pf_out
      ppath: prefactor
      wpath: workdir
      res2: parse2/res2
    out: [sub_parset]

  initsub:
    run: factor/initsub.cwl
    in: 
      shared: binddir
      cimage: container
      pipecfg: prepcfg/cfg_fname
      parset: prepsub/sub_parset
    out: [out_file3]

  parse3:
    run: factor/parse3.cwl
    in:
      parse1_out: parse1/res1
      parse2_out: parse2/res2
      inifac_out: initsub/out_file3
    out: [res]

  prepfac:
    run: factor/prepfac.cwl
    in: 
      src: fac_src
      facin: pf_out
      wpath: workdir
      wms: WMS
      res3: parse3/res
    out: [fac_parset]

  ddcfac:
    run: factor/ddcfac.cwl
    in: 
      shared: binddir
      cimage: container
      wpath: workdir
      parset: prepfac/fac_parset
    out: [all_done]

