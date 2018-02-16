#!/usr/bin/python

#----------------------------------------------------#
#  getFileFromUrlList.py                             # 
#  Jim Hofman                                            #
#  Saves files from a list of urls                   #
#                                                                 #
#----------------------------------------------------#

# Revisions
# 8-18-2014 - added switch to direct downloaded files  to a specific directory
#                  - added usage() method


from urllib import urlretrieve
from os import path, getcwd
import sys, getopt
from time import time
       

# Returns a file from the url and saves it as 'fname'
def save_file_from_url(local_url, dir): 
    # split the url and get the last element in the list (the file name)
    fname = local_url.split('/')[-1] 
    print "Downloading: " + local_url
    try:
       urlretrieve(local_url, dir+fname.strip(), reporthook)              
    except Exception, e:
       print('Error downloading %s: error: %s' % (local_url, e))

def reporthook(count, block_size, total_size):
   global start_time
   if count == 0:          # first pass, initialize the time
      start_time = time()
      return
   duration = time() - start_time
   size     = int(count * block_size)
   speed    = int(size / (1024 * duration))
   percent  = min(int(count * block_size * 100 / total_size),100)
   sys.stdout.write("\r...%d%% @ %d KBytes/second, Download time: %d  seconds" % \
               (percent, speed, duration))
   sys.stdout.flush()        
  
       
def usage():
   print'There are only 2 options: ' 
   print'       -o <dir> or --output <dir> to specify a path to an output directory in which to store the downloaded files.'
   print'           NOTE:  the output directory must exist.  If no directory is specified, the files will be donwloaded '
   print'           to the directory in which the script is running.'
   print'      -h to display this message '   
 
 
def main(argv):
    
   # Declarations
   # output_dir - specifies directory in which to store the file (default - directory in which the script is run.
   output_dir = ''
    # file_list is a list or all the urls from which we will retrieve a file
   file_list =["http://co2web.jpl.nasa.gov/thredds/fileServer/OCO-2/B8100r_r02/2015/01/15/LtCO2/oco2_LtCO2_150115_B8100r_171012042804s.nc4"]

   try:
        opts, args = getopt.getopt(argv,'ho:', ['output='])
   except:
        print "Exception getting arguments."
        usage()
   for opt, arg in opts:
        if opt == '-h':
           usage()
           sys.exit()
        elif opt in ('-o', '--output'):
           output_dir = arg
           print 'Output directdory is %s' % output_dir
        else:
            pass

   for url in file_list:
      try:
         save_file_from_url(url, output_dir) 
      except Exception, e: 
         print('Could not save file from: %s' % url)
   print '\nDone'

if __name__ == "__main__":
    main(sys.argv[1:])
