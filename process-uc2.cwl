#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: 
  calms: string
  tarms: string
  templatedir: string
  factordir: string
  prefactor: string
  workdir: string
  datadir: string
  container: string
  binddir: string
  WMS: string

outputs:
  status:
    type: File
    outputSource: ddcfac/all_done

steps:
  caldir:
    run: factor/msdir.cwl
    in:
      obsms: calms
      datadir: datadir
    out: [ms_ok]

  tardir:
    run: factor/msdir.cwl
    in:
      obsms: tarms
      datadir: datadir
    out: [ms_ok]

  prep2run:
    run: factor/prep2run.cwl
    in:
      workdir: workdir
    out: [ready2run]

  prepcfg:
    run: factor/prepcfg.cwl
    in: 
      templatedir: templatedir
      prefactor: prefactor
      workdir: workdir
      cal_ready: caldir/ms_ok
      tar_ready: tardir/ms_ok
      dir_ready: prep2run/ready2run
    out: [cfg_fname]

  prepcal:
    run: factor/prepcal.cwl
    in: 
      calms: calms
      templatedir: templatedir
      datadir: datadir
      prefactor: prefactor
      workdir: workdir
      cfg_file: prepcfg/cfg_fname
    out: [cal_parset]

  calcal:
    run: factor/calcal.cwl
    in: 
      binddir: binddir
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
      tarms: tarms
      templatedir: templatedir
      datadir: datadir
      prefactor: prefactor
      workdir: workdir
      res1: parse1/res1
    out: [tar_parset]

  tarcal:
    run: factor/tarcal.cwl
    in: 
      pipecfg: prepcfg/cfg_fname
      parset: preptar/tar_parset
      cimage: container
      binddir: binddir
    out: [out_file2]

  parse2:
    run: factor/parse2.cwl
    in:
      tarcal_out: tarcal/out_file2
    out: [res2]

  prepsub:
    run: factor/prepsub.cwl
    in: 
      tarms: tarms
      templatedir: templatedir
      prefactor: prefactor
      workdir: workdir
      res2: parse2/res2
    out: [sub_parset]

  initsub:
    run: factor/initsub.cwl
    in: 
      pipecfg: prepcfg/cfg_fname
      parset: prepsub/sub_parset
      cimage: container
      binddir: binddir
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
      templatedir: templatedir
      factordir: factordir
      workdir: workdir
      wms: WMS
      res3: parse3/res
    out: [fac_parset]

  ddcfac:
    run: factor/ddcfac.cwl
    in: 
      factordir: factordir
      parset: prepfac/fac_parset
      cimage: container
      binddir: binddir
    out: [all_done]

