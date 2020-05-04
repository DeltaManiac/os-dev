#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(divios::test_runner)]
#![reexport_test_harness_main = "test_main"]
use bootloader::entry_point;
use bootloader::BootInfo;
use core::panic::PanicInfo;
use divios::println;

entry_point!(kernel_main);

fn kernel_main(boot_info: &'static BootInfo) -> ! {
    use divios::memory;
    use x86_64::structures::paging::MapperAllSizes;
    use x86_64::structures::paging::Page;
    use x86_64::VirtAddr;

    println!("Welcome to {}", "DiviOS v0.1-pre-alpha");
    divios::init();

    let phys_mem_offset = VirtAddr::new(boot_info.physical_memory_offset);
    let mut mapper = unsafe { memory::init(phys_mem_offset) };
    let mut frame_allocator =
        unsafe { memory::BootInfoFrameAllocator::init(&boot_info.memory_map) };
    // let page = Page::containing_address(VirtAddr::new(0));
    let page = Page::containing_address(VirtAddr::new(0xdeadbeaf000));
    memory::create_example_mapping(page, &mut mapper, &mut frame_allocator);
    let page_ptr: *mut u64 = page.start_address().as_mut_ptr();
    unsafe { page_ptr.offset(400).write_volatile(0x_f021_f077_f065_f04e) };
    let addresses = [
        0xb8000,
        0x201008,
        0x0100_0020_1a10,
        boot_info.physical_memory_offset,
    ];
    for &address in &addresses {
        let virt = VirtAddr::new(address);
        let phys = mapper.translate_addr(virt);
        // let phys = unsafe { translate_addr(virt, phys_mem_offset) };
        println!("{:?} => {:?}", virt, phys);
    }

    #[cfg(test)]
    test_main();
    println!("It no crash!");
    divios::hlt_loop();
}

#[cfg(not(test))]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    loop {}
}

#[cfg(test)]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    divios::test_panic_handler(info);
}
