# encoding: utf-8

namespace :db do
  desc "Empty existing data from OligoSequence and Fill database with default sample filter data"
  task :addoligo => :environment do

    existing_oligos = OligoSequence.all()
    for efs in existing_oligos do
        efs.destroy
    end

#non c'è la tabella tax_id
#insert all data of oligo
    
#taxonomy_id, :decimal, :default => 0, :precision => 2, :scale => 0
#taxonomy_name, :string
# in second time during Edit


OligoSequence.create!( :code => "GEN-702", :oligoDate => "2011/01/01", :partner_people_id => 2, :partner_id => 1 , :people_id =>2, :dna_sequence => "GATCTCATTAGGTTGCGTATGTTGAGAAGCG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "rpoS reverse Lolita")
OligoSequence.create!( :code => "GEN-703", :oligoDate => "2011/01/01", :partner_people_id => 2, :partner_id => 1 , :people_id =>2, :dna_sequence => "CGTTGTAAAACGACGGCCAGTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "pBluescript forward")
OligoSequence.create!( :code => "GEN-704", :oligoDate => "2011/01/01", :partner_people_id => 2, :partner_id => 1 , :people_id =>2, :dna_sequence => "GATCTCACTAGCCATCCTGCAAACCTTCACG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ProP reverse Lolita-Dan")
OligoSequence.create!( :code => "GEN-705", :oligoDate => "2011/01/01", :partner_people_id => 16, :partner_id => 1 , :people_id =>16, :dna_sequence => "CATGCCATGGTTATGATGGATATGGGACAT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "VirF NcoI  MARA")
OligoSequence.create!( :code => "GEN-706", :oligoDate => "2011/01/01", :partner_people_id => 16, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATGGGCTATGAATTCATTAAAATTTTTTATGAT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "VirF EcoRI   MARA")
OligoSequence.create!( :code => "GEN-707", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAGGGCGCCATGTCCTGTAAAATGACTGGTATC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "CspA G3C")
OligoSequence.create!( :code => "GEN-708", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATACCAGTCATTTTACAGGACATGGCGCCCTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "CspA G3C")
OligoSequence.create!( :code => "GEN-709", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GGCTTAATGCACATCTGCGGTTTGACGTACAGAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "CspA +1 transcript")
OligoSequence.create!( :code => "GEN-710", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTCTGTACGTCAAACCGCAGATGTGCATTAAGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "CspA +1 transcript")
OligoSequence.create!( :code => "GEN-711", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAGGGCGCCATGGCATGTAACATTACCAGCAAAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "mut PY: M3C")
OligoSequence.create!( :code => "GEN-712", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTTTGCTGGTAATGTTACATGCCATGGCGCCCTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "mut PY: M3C")
OligoSequence.create!( :code => "GEN-713", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAATACACCTAACGGCTGTCTGGTTGCCAGTGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "mut PY: V60C")
OligoSequence.create!( :code => "GEN-714", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCACTGGCAACCAGACAGCCGTTAGGTGTATTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "mut PY: V60C")
OligoSequence.create!( :code => "GEN-715", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCAAGGCCGTACTCCAACTGTAATCAAAAAAGCAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Ala116/Thr")
OligoSequence.create!( :code => "GEN-716", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTGCTTTTTTGATTACAGTTGGAGTACGGCCTTGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Ala116/Thr")
OligoSequence.create!( :code => "GEN-717", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GACTGGCCAAGGCCGTAATCCAGCTGTAATCAAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Thr114/Asn")
OligoSequence.create!( :code => "GEN-718", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTTGATTACAGCTGGATTACGGCCTTGGCCAGTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Thr114/Asn")
OligoSequence.create!( :code => "GEN-719", :oligoDate => "2011/03/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AAAGTGAAACCATAATATGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "VirF Promoter (240 bp) -173")
OligoSequence.create!( :code => "GEN-721", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTTGTCACTACTTTCGGTCATGGTGTTCAATGCTTTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP-Blue color (Y66/H)")
OligoSequence.create!( :code => "GEN-722", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAAAGCATTGAACACCATGACCGAAAGTAGTGACAAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP-Blue color (Y66/H)")
OligoSequence.create!( :code => "GEN-723", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTGAAGGTGATGCAACAAACGGAAAACTTACCCTTAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Y39/N")
OligoSequence.create!( :code => "GEN-724", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTAAGGGTAAGTTTTCCGTTTGTTGCATCACCTTCAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Y39/N")
OligoSequence.create!( :code => "GEN-725", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GGAAAGAACTATATCTTTCAAAGATGACGGGACCTACAAGACACGTG", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP F99/S and N105/T")
OligoSequence.create!( :code => "GEN-726", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CACGTGTCTTGTAGGTCCCGTCATCTTTGAAAGATATAGTTCTTTCC", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP F99/S and N105/T")
OligoSequence.create!( :code => "GEN-727", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GAATGGAATCAAAGCTAACTTCAAAATTAGACACAACGTTGAAGATGGAAGCG", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP V163/A and I171/V")
OligoSequence.create!( :code => "GEN-728", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCTTCCATCTTCAACGTTGTGTCTAATTTTGAAGTTAGCTTTGATTCCATTC", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP V163/A and I171/V")
OligoSequence.create!( :code => "GEN-729", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GGGTGAAGGTGATGCAACAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Screening mutant GFP Y39/N")
OligoSequence.create!( :code => "GEN-730", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TCTTTCAAAGATGACGGGAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Screening mutant GFP N105/T")
OligoSequence.create!( :code => "GEN-731", :oligoDate => "2011/05/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTCACACAATGTATACATCAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Screening mutant GFP I171/V")
OligoSequence.create!( :code => "up_mefA_orf2", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "GGATTCACATTCCTGAAGATAAAGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "DEZY")
OligoSequence.create!( :code => "GEN-732", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AAATTACTTAATCTATCTTA", :available =>0,  :description => "1 umol       FPLC               [auto import.]    ", :name => "ordered at ROCHE and delivered to M7")
OligoSequence.create!( :code => "GEN-733", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TAAGATAGATTAAGTAATTT", :available =>0,  :description => "1 umol       FPLC               [auto import.]    ", :name => "ordered at ROCHE and delivered to M7")
OligoSequence.create!( :code => "GEN-291bis", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATGCGTCCGGCGTAGA", :available =>0,  :description => "ordered by Dezy                      [auto import.]    ", :name => "downstream pETM-11 polylinker")
OligoSequence.create!( :code => "GEN-734", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCCGAACGAACTGCTGAATTGTAGCCTTGCTGCCGTT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Insertion of Cys between aa 77-78 of HNS linker (in pETM)")
OligoSequence.create!( :code => "GEN-735", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AACGGCAGCAAGGCTACAATTCAGCAGTTCGTTCGGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "As above")
OligoSequence.create!( :code => "GEN-736", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCCCAGTCCTGCTCGCTTCGCTAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "upstream BamHI pBR328")
OligoSequence.create!( :code => "GEN-737", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCATCGGTGATGTCGGCGATATAGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "downstream BamHI pBR328")
OligoSequence.create!( :code => "GEN-738", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAACCATTACCTGTCCTATCAATCTGCCCTTTCG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP  T203Y to obtain yellow fluor protein (F)")
OligoSequence.create!( :code => "GEN-739", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGAAAGGGCAGATTGATAGGACAGGTAATGGTTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP  T203Y to obtain yellow fluor protein (rev)")
OligoSequence.create!( :code => "GEN-740", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAACCATTACCTGTCCTATCAATCTGTCCTTTCG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP  T203Y to obtain yellow fluor protein in superfolder GFP (F)")
OligoSequence.create!( :code => "GEN-741", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGAAAGGACAGATTGATAGGACAGGTAATGGTTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP  T203Y to obtain yellow fluor protein in superfolder GFP (rev)")
OligoSequence.create!( :code => "10500R_2", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "TCTGCATTCAAATGACTTAATTCGT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Per Dezy")
OligoSequence.create!( :code => "GEN-742", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTGGACTGGCCAAGGCCTTAATCCAGCTGTAATC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Arg113/Leu")
OligoSequence.create!( :code => "GEN-743", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATTACAGCTGGATTAAGGCCTTGGCCAGTCCAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Arg113/Leu")
OligoSequence.create!( :code => "GEN-744", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CAAATTGGAATACAACTTTAACTCACACAATGTATACATCACGGCAGACAAACAAAAG", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Y145F & M153T")
OligoSequence.create!( :code => "GEN-745", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTTTTGTTTGTCTGCCGTGATGTATACATTGTGTGAGTTAAAGTTGTATTCCAATTTG", :available =>0,  :description => "0.05       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Y145F & M153T")
OligoSequence.create!( :code => "GEN-746", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCTGTCCACACAATCTGTCCTTTCGAAAGATCCCAAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Ala206/Val")
OligoSequence.create!( :code => "GEN-747", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTTGGGATCTTTCGAAAGGACAGATTGTGTGGACAGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP Ala206/Val")
OligoSequence.create!( :code => "GEN-748", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTCGGAACGGTCATTAAAGCGAAGCTCGACAAAGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Bst IF2 Glu424/Lys")
OligoSequence.create!( :code => "GEN-749", :oligoDate => "2011/06/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCTTTGTCGAGCTTCGCTTTAATGACCGTTCCGAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Bst IF2 Glu424/Lys")
OligoSequence.create!( :code => "GEN-750", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GACTGGCCAAGGCCGTACTGCAGCTGTAATCAAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Pro115/Ala")
OligoSequence.create!( :code => "GEN-751", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTTGATTACAGCTGCAGTACGGCCTTGGCCAGTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "HNS Pro115/Ala")
OligoSequence.create!( :code => "GEN-752", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTTTAAATGGCGAACAGCC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "23S 2552  Attilio")
OligoSequence.create!( :code => "GEN-753", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATATGAACTCTTGGGCGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "23S 2462  Attilio")
OligoSequence.create!( :code => "GEN-754", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATTATGCCATCGCCCAGAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (f)")
OligoSequence.create!( :code => "GEN-755", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TCGTTCCTGTTGATGTATGCC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (f)")
OligoSequence.create!( :code => "GEN-756", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCTCTCGTTCCTGTTGATG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (f)")
OligoSequence.create!( :code => "GEN-757", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCTGCTCGATGTCGAAGAAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (r)")
OligoSequence.create!( :code => "GEN-758", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCACATCTCGTAGAAATAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (r)")
OligoSequence.create!( :code => "GEN-759", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TACATCAACAGGAACGAGAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 95 Amph.coff. (r)")
OligoSequence.create!( :code => "GEN-760", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GGTATGTGTCCGCACTTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Parvularcula bermudensis")
OligoSequence.create!( :code => "GEN-761", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATTCTGCTCGGTCTTGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Parvularcula bermudensis")
OligoSequence.create!( :code => "GEN-762", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AGCAGGTACATATCGAAGGT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Xantomonas axono.")
OligoSequence.create!( :code => "GEN-763", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTCTACGGCATCGCACAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Xantomonas axono.")
OligoSequence.create!( :code => "GEN-764", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCCATTGCCAGGTATTCG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Xantomonas campestris")
OligoSequence.create!( :code => "GEN-765", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCAGTGTTCTACGGCATT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Control Xantomonas campestris")
OligoSequence.create!( :code => "GEN-766", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTCCTGGCTCCACAATTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 78 Amph.coff. (f)")
OligoSequence.create!( :code => "GEN-767", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AACCGCGAATGCATCATC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 78 Amph.coff. (r)")
OligoSequence.create!( :code => "#759 bis", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCGGTAATTCCAGCTCCAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Diatom rDNA")
OligoSequence.create!( :code => "#812bis", :oligoDate => "2011/08/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AACACTCTAATTTTTTCACAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Diatom rDNA")
OligoSequence.create!( :code => "GEN-768", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCATCAGCAGCACCAGCAT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 68 Amphora coff.")
OligoSequence.create!( :code => "GEN-769", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTGGCGGATGAGGGCAAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 68 Amphora coff.")
OligoSequence.create!( :code => "GEN-770", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GGAGCTGCATGTGTCAGAGG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "GFP downstream EcoRV")
OligoSequence.create!( :code => "GEN-771", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTAATGCGACGACACTCATCAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvarcula control #1")
OligoSequence.create!( :code => "GEN-772", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ATTATCGACGATGGACACAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvularcula control #2")
OligoSequence.create!( :code => "GEN-773", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ATTGTCGCCAAACTTCGTA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvarcula control #3")
OligoSequence.create!( :code => "GEN-774", :oligoDate => "2011/10/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCTCTGCTTTGGCGATTTGA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvarcula control #4")
OligoSequence.create!( :code => "GEN-775", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTACTTGGTATTTGTTCAGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 70 Amphora coff.")
OligoSequence.create!( :code => "GEN-776", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ACGAACAATACAGAAGCAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 70 Amphora coff.")
OligoSequence.create!( :code => "GEN-777", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TCCTCGTCGCCGTCCTGGCTCC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 79 Amphora coff.")
OligoSequence.create!( :code => "GEN-778", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGGCGCTGCGCAACCGCGAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 79 Amphora coff.")
OligoSequence.create!( :code => "GEN-779", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TTCCTCGCCCGCGGCGCACA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 97 Amphora coff.")
OligoSequence.create!( :code => "GEN-780", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ACCGACAAGGCGACCCACGGCT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Sample 97 Amphora coff.")
OligoSequence.create!( :code => "GEN-781", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ACCTGATGATAATCGTAGTCC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvularcula downstream  Par1")
OligoSequence.create!( :code => "GEN-782", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGGTTAAACGAGCTGATAAAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Parvularcula downstream Par2")
OligoSequence.create!( :code => "SEA-1", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "GAAAAAAGTCTGAATTGCAGGGAACA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "SEA-1 Dezy")
OligoSequence.create!( :code => "SEA-2", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "CAAATAAATCGTAATTAACCGAAGGTTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "SEA-2 Dezy")
OligoSequence.create!( :code => "TST-1", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "TTCACTATTTGTAAAAGTGTCAGACCCACT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "TST-1 Dezy")
OligoSequence.create!( :code => "TST-2 ", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "TACTAATGAATTTTTTTATCGTAAGCCCTT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "TST-2 Dezy")
OligoSequence.create!( :code => "PVL-1", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATCATTAGGTAAAATGTCTGGACATGATCCA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "PVL-1 Dezy")
OligoSequence.create!( :code => "NPVL-2", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "GCATCAASTGTATTGGATAGCAAAAGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NPVL-2  Dezy")
OligoSequence.create!( :code => "spa-1F", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATCAACGTATATAAGTTAAAATTGGTTTGGA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "DEZY+LUCA")
OligoSequence.create!( :code => "spa-1R", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATATTTATTTTATAAGTTGTAAAACTTACCTTTAAATTTAATT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "DEZY+LUCA")
OligoSequence.create!( :code => "spa-2R", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "AAAATGCACTGAGCAACAAAAGATG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "DEZY+LUCA")
OligoSequence.create!( :code => "spa-3F", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>16, :dna_sequence => "ATAGCGTGATTTTGCGGTT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "DEZY+LUCA")
OligoSequence.create!( :code => "GEN-783", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCGTGAGGTTTTTACGATAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "PCR on plasmid pNCK")
OligoSequence.create!( :code => "GEN-784", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CATGGCAAAAGAAAAATTCGATCGTTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Ef-Tu Staphyl-aureus-Enzyme-free cloning")
OligoSequence.create!( :code => "GEN-785", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTTATTTAATGATTTCAGTAACAACGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Ef-Tu Staphyl-aureus-Enzyme-free cloning")
OligoSequence.create!( :code => "GEN-786", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCAAAAGAAAAATTCGATCGTTCTAAAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Ef-Tu Staphyl-aureus-Enzyme-free cloning")
OligoSequence.create!( :code => "GEN-787", :oligoDate => "2011/11/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATCCTTATTTAATGATTTCAGTAACAACG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "Ef-Tu Staphyl-aureus-Enzyme-free cloning")
OligoSequence.create!( :code => "GEN-788", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "TATGGCGGATTGCTGTTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P20")
OligoSequence.create!( :code => "GEN-789", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "ATGAGGTTCTCGGCCTTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P20")
OligoSequence.create!( :code => "GEN-790", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GCTACCCGTGCGATTCGTCC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P23")
OligoSequence.create!( :code => "GEN-791", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCCAGGAATCGTGAACGCT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P23")
OligoSequence.create!( :code => "GEN-792", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CTCGCCACAGAGATACAA", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P24")
OligoSequence.create!( :code => "GEN-793", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGTGTTCCTGTCCAATGT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "NIT-SIG-P24")
OligoSequence.create!( :code => "GEN-794", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATCTCAGCTCAGGTGTG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P20")
OligoSequence.create!( :code => "GEN-795", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GAGGCAGCACTCTGAAAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P20")
OligoSequence.create!( :code => "GEN-796", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CCTGCCGATCCGCATGAC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P21")
OligoSequence.create!( :code => "GEN-797", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GATCGTTACCAGTTCGCATTT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P21")
OligoSequence.create!( :code => "GEN-798", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTTCTGTACCACCGGGTAG", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P26")
OligoSequence.create!( :code => "GEN-799", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "AGTGCTGACCGAAACCAT", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "ACH-MIN-P26")
OligoSequence.create!( :code => "GEN-800", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "GTTGAGATAGGTACCGAGC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "AMPH_COFF_93")
OligoSequence.create!( :code => "GEN-801", :oligoDate => "2011/12/01", :partner_people_id => 3, :partner_id => 1 , :people_id =>3, :dna_sequence => "CGGCTTCATTCTGGTCTC", :available =>0,  :description => "0.025       DESALT       Ship Complete        [auto import.]    ", :name => "AMPH_COFF_93")




  end
end

