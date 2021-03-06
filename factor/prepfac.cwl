#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: python

inputs:
  templatedir: string
  factordir: string
  workdir: string
  wms: string
  res3: string

arguments:
 - prefix: -c
   valueFrom: |
    import re
    import json
    facin = "$(inputs.workdir)" + "/prefactor_output"
    FAC_MAP = {'^dir_working.+': 'dir_working = $(inputs.factordir)',
              '^dir_ms.+': 'dir_ms = ' + facin + '/Pre-Facet-Target/results',
               '^\\[ms1\\.ms\\]\\s*': '#[ms1.ms]\\n',
               '^\\[ms2\\.ms\\]\\s*': '#[ms2.ms]\\n'
    }
    dstfile = "$(inputs.workdir)" + "/factor.parset"
    srcfile = "$(inputs.templatedir)" + "/factor.parset"
    with open(srcfile, "r") as reader:
        lines = reader.readlines()
    with open(dstfile, "w") as writer:
        for line in lines:
            mf = False
            for ptn in FAC_MAP:
                if re.search(ptn, line):
                    mf = True
                    writer.write(re.sub(ptn, FAC_MAP[ptn], line))
            if not mf:
                writer.write(line)
    with open("cwl.output.json", "w") as output:
        json.dump({"fac_parset": dstfile}, output)

outputs:
  fac_parset: string
