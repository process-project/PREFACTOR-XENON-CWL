#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: python

inputs:
  calms: string
  datadir: string
  workdir: string
  cfg_file: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import os
    import json
    caldir = "$(inputs.datadir)" + "/data/L" + "$(inputs.calms)"
    mspattern = "L" + "$(inputs.calms)" + "_SB*.MS"
    CAL_MAP = {'^! cal_input_path.+': '! cal_input_path = ' + caldir,
               '^! cal_input_pattern.+': '! cal_input_pattern = ' + mspattern,
               '^! prefactor_directory.+': '! prefactor_directory = /opt/lofar/prefactor',
               '^! losoto_directory.+': '! losoto_directory = /opt/lofar/losoto',
               '^! aoflagger.+': '! aoflagger = /opt/lofar/aoflagger/bin/aoflagger',
               '^! max_dppp_threads.+': '! max_dppp_threads = 2'
    }
    psfile = "Pre-Facet-Calibrator.parset"
    srcfile = "/opt/lofar/templates/" + psfile
    dstfile = "$(inputs.workdir)" + "/" + psfile
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


