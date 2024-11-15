#include <genlib.h>  
  
main()  
{  
int i;  
  
   GENLIB_DEF_LOFIG("mult_top");  
  
   GENLIB_LOCON("vdd",           IN,        "vdd");    
   GENLIB_LOCON("vss",           IN,        "vss");    
   GENLIB_LOCON("vdde",          IN,       "vdde");   
   GENLIB_LOCON("vsse",          IN,       "vsse");   
   GENLIB_LOCON("a[3:0]",        IN,     "a[3:0]");    
   GENLIB_LOCON("b[3:0]",        IN,     "b[3:0]");    
   GENLIB_LOCON("reset",         IN,      "reset");    
   GENLIB_LOCON("start",         IN,      "start");    
   GENLIB_LOCON("clk",            IN,         "clk");    
   GENLIB_LOCON("ready",        OUT,      "ready"); 
   GENLIB_LOCON("cat[3:0]",        OUT,      "cat[3:0]");
   GENLIB_LOCON("p[4:0]",        OUT,      "p[4:0]");   
     
     
                              
   GENLIB_LOINS ("pvsse_sp", "p21", "clki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvdde_sp", "p22", "clki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvddeck_sp", "p23", "clock", "clki", "vdde", "vdd", "vsse", "vss",0); 
   GENLIB_LOINS ("pvssi_sp", "p24", "clki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvddi_sp", "p25", "clki", "vdde", "vdd", "vsse", "vss", 0);  
  
   for (i = 0; i < 4; i++)  
    GENLIB_LOINS("pi_sp", GENLIB_NAME("p%d", i),   
          GENLIB_NAME("a[%d]", i), GENLIB_NAME("aa[%d]", i),   
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
  
   for (i = 0; i < 4; i++)  
    GENLIB_LOINS("pi_sp", GENLIB_NAME("p%d", i + 4),   
          GENLIB_NAME("b[%d]", i), GENLIB_NAME("bb[%d]", i),   
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
  
  for (i = 0; i < 5; i++)  
    GENLIB_LOINS("po_sp", GENLIB_NAME("p%d", i + 8),   
          GENLIB_NAME("pp[%d]", i), GENLIB_NAME("p[%d]", i),  
         "clki", "vdde", "vdd", "vsse", "vss", 0); 


   for (i = 0; i < 4; i++)  
    GENLIB_LOINS("po_sp", GENLIB_NAME("p%d", i + 13),   
          GENLIB_NAME("catcat[%d]", i), GENLIB_NAME("cat[%d]", i),  
         "clki", "vdde", "vdd", "vsse", "vss", 0); 
		 
			 
  
  
   GENLIB_LOINS("pi_sp", "p17",  
         "start", "startstart",  
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("pi_sp", "p18",  
         "reset", "resetreset",  
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("pck_sp", "p19",  
         "clk",  
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("po_sp", "p20",  
         "readyready", "ready",  
         "clki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("mult", "mult",  
   	     "clock", "resetreset",
  	     "aa[3:0]", "bb[3:0]", 
         "startstart",
   	 "catcat[3:0]",
         "pp[4:0]",
         "readyready", 
         "vdd", "vss", 0);  
  
   GENLIB_SAVE_LOFIG();  
   exit(0);   
}  
