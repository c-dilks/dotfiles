void memplot()
{
  TTree * tr = new TTree("tr","tr");
  gROOT->ProcessLine(".! cp mem.dat mem2.dat");
  tr->ReadFile("mem2.dat","time:mem");
  Int_t tbins = 10*tr->GetEntries();
  //TH2D * pl = new TH2D("pl","test",tbins,0,tbins,13000,0,13000);
  tr->Draw("mem:time","","*");
  //pl->GetYaxis()->SetTitle("Memory (MB)");
  //pl->GetXaxis()->SetTitle("Time (s)");
  //pl->Draw("*");
};
