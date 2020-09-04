from Bio import SeqIO
import argparse

# usage     
# sliceFasta.py --fasta sample.fasta --dataFile guide.txt --output myout.fasta 

def walkOverCorrdinates(datafile): 
 	with open(datafile) as input_coordinates: 
 		lines=input_coordinates.readlines()
 	return lines

def parseseq(data_lines, input_fasta, outputfile): 
	parsed_fasta = SeqIO.parse(input_fasta, "fasta")
	for line in lines: 
		header = line.split()
		for record in SeqIO.parse(input_fasta, "fasta"):
			if header[0] in record.id:
				index_left = int(header[1])
				index_right = int(header[2])
				record.seq =record.seq[index_left-1:index_right-1] 
				with open(outputfile, "a") as output_handle:
					SeqIO.write(record, output_handle, "fasta")


if __name__ == "__main__":
	parser = argparse.ArgumentParser(description="parsing VCF file and generates SWAAT input")
	# Arguments
	parser.add_argument("--fasta", help="Fasta files to be sliced")
	parser.add_argument("--dataFile", help="File containing the slice coordinates")
	parser.add_argument("--output", help="Output fasta file")
	args = parser.parse_args()
	lines = walkOverCorrdinates(args.dataFile)
	parseseq(lines, args.fasta, args.output)



