#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(divios::test_runner)]
#![reexport_test_harness_main = "test_main"]

use core::panic::PanicInfo;
use divios::{println, serial_print, serial_println};

#[no_mangle]
pub extern "C" fn _start() -> ! {
    test_main();

    loop {}
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    divios::test_panic_handler(info)
}

#[test_case]
fn test_println() {
    serial_print!("test_print... ");
    println!("test_println output");
    serial_println!("[ok]");
}
