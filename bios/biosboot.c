extern void __enable_IA_32e_paging();
extern void __jmp_kernel();
extern void __check_support();

static void create_table(){

    // Set PML4
    // We set only one entry.
    char * start = (char*)0x10000;
    *start |= (1<<1); // read/write
    *start |= (1<<0); // bit present                       
    start++;

    // Bytes 11:8 are ignored.
    // And we want ot point to 0x11000
    // So we do it this:
    //      0x11000/4096 = 17
    //
    // We need to cast it so it wont cut anything.
    // One byte is 0x00 so we need to offset it by 0x0.
    *(int*)start = 0x110;

    // Now we set PDPT
    start = (char*)0x11000;
    *start |= (1<<1); // read/write
    *start |= (1<<0); // bit present                       
    start++;
    *(int*)start = 0x120;

    // Now we set PDT
    start = (char*)0x12000;
    *start |= (1<<1); // read/write
    *start |= (1<<0); // bit present                       
    start++;
    *(int*)start = 0x130;

    // Now we set one page (4kb)
    // So we need 512 entries.
    for(int x = 0; x < 512; x++){

        start = (char*)0x13000 + (8*x); // offset entry
        *start |= (1<<1); // read/write
        *start |= (1<<0); // bit present                       
        start++;
        // We start maping from 0x0000 and we are mapping 2MB.
        // This is made to not brake current addrresses.
        *(int*)start = 0x00 + (0x10*x);

    }

}

int __c_biosboot(){

    create_table();

    __check_support();

    __enable_IA_32e_paging();

    __jmp_kernel();

    while(1);

}
