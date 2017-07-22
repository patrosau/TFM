from os import listdir
from os.path import isfile, join


class directoryHelper:
    def __init__(self, dirname):
        self.dirname = dirname

    def getFiles(self):
        return [join(self.dirname, f) for f in listdir(self.dirname) if isfile(join(self.dirname, f))]