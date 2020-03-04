#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(divios::test_runner)]
#![reexport_test_harness_main = "test_main"]

use core::panic::PanicInfo;
use divios::println;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    println!("Hello {}", "Divita");
    divios::init();
    #[cfg(test)]
    test_main();
    println!("It no crash!");
    loop {}
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
