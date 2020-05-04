#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs: 
  calms: string
  tarms: string
  factordir: string
  workdir: string
  datadir: string

outputs:
  status:
    type: File
    outputSource: ddcfac/all_done

steps:
  caldir:
    run: /opt/lofar/cwl/factor/msdir.cwl
    in:
      obsms: calms
      datadir: datadir
    out: [ms_ok]

  tardir:
    run: /opt/lofar/cwl/factor/msdir.cwl
    in:
      obsms: tarms
      datadir: datadir
    out: [ms_ok]

  prep2run:
    run: /opt/lofar/cwl/factor/prep2run.cwl
    in:
      workdir: workdir
    out: [ready2run]

  prepcfg:
    run: /opt/lofar/cwl/factor/prepcfg.cwl
    in: 
      workdir: workdir
      cal_ready: caldir/ms_ok
      tar_ready: tardir/ms_ok
      dir_ready: prep2run/ready2run
    out: [cfg_fname]

  prepcal:
    run: /opt/lofar/cwl/factor/prepcal.cwl
    in: 
      calms: calms
      datadir: datadir
      workdir: workdir
      cfg_file: prepcfg/cfg_fname
    out: [cal_parset]

  calcal:
    run: /opt/lofar/cwl/factor/calcal.cwl
    in: 
      pipecfg: prepcfg/cfg_fname
      parset: prepcal/cal_parset
    out: [out_file1]

  parse1:
    run: /opt/lofar/cwl/factor/parse1.cwl
    in:
      calcal_out: calcal/out_file1
    out: [res1]

  preptar:
    run: /opt/lofar/cwl/factor/preptar.cwl
    in: 
      tarms: tarms
      datadir: datadir
      workdir: workdir
      res1: parse1/res1
    out: [tar_parset]

  tarcal:
    run: /opt/lofar/cwl/factor/tarcal.cwl
    in: 
      pipecfg: prepcfg/cfg_fname
      parset: preptar/tar_parset
    out: [out_file2]

  parse2:
    run: /opt/lofar/cwl/factor/parse2.cwl
    in:
      tarcal_out: tarcal/out_file2
    out: [res2]

  prepsub:
    run: /opt/lofar/cwl/factor/prepsub.cwl
    in: 
      tarms: tarms
      workdir: workdir
      res2: parse2/res2
    out: [sub_parset]

  initsub:
    run: /opt/lofar/cwl/factor/initsub.cwl
    in: 
      pipecfg: prepcfg/cfg_fname
      parset: prepsub/sub_parset
    out: [out_file3]

  parse3:
    run: /opt/lofar/cwl/factor/parse3.cwl
    in:
      parse1_out: parse1/res1
      parse2_out: parse2/res2
      inifac_out: initsub/out_file3
    out: [res]

  prepfac:
    run: /opt/lofar/cwl/factor/prepfac.cwl
    in: 
      factordir: factordir
      workdir: workdir
      res3: parse3/res
    out: [fac_parset]

  ddcfac:
    run: /opt/lofar/cwl/factor/ddcfac.cwl
    in: 
      factordir: factordir
      parset: prepfac/fac_parset
    out: [all_done]

