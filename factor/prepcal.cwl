#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  obs: string
  dpath: string
  ppath: string
  wpath: string
  cfg_file: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    CAL_MAP = {'^! cal_input_path.+': '! cal_input_path = $(inputs.dpath)'+ "/LC2_038_SASid_232873",
               '^! cal_input_pattern.+': '! cal_input_pattern = L232873_SB*.MS',
               '^! prefactor_directory.+': '! prefactor_directory = $(inputs.ppath)',
               '^! losoto_directory.+': '! losoto_directory = /opt/lofar/losoto',
               '^! aoflagger.+': '! aoflagger = /opt/lofar/aoflagger/bin/aoflagger',
               '^! max_dppp_threads.+': '! max_dppp_threads = 10'
    }
    psfile = "Pre-Facet-Calibrator.parset"
    srcfile = "$(inputs.ppath)" + "/" + psfile
    dstfile = "$(inputs.wpath)" + "/" + psfile
    with open(srcfile, "r") as reader:
        lines = reader.readlines()
    with open(dstfile, "w") as writer:
        for line in lines:
            mf = False
            for ptn in CAL_MAP:
                if re.search(ptn, line):
                    mf = True
                    writer.write(re.sub(ptn, CAL_MAP[ptn], line))
            if not mf:
                writer.write(line)
    with open("cwl.output.json", "w") as output:
        json.dump({"cal_parset": dstfile}, output)

outputs:
  cal_parset: string


