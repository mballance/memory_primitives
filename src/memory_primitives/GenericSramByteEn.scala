package memory_primitives

import std_protocol_if.GenericSramByteEnIf
import chisel3._
import chisel3.experimental._

class GenericSramByteEn(val p : GenericSramByteEnIf.Parameters) extends Module {
  
  val io = IO(new Bundle {
    val s = Flipped(new GenericSramByteEnIf(p))
  })
  
}

class generic_sram_byte_en(val p : GenericSramByteEnIf.Parameters) extends BlackBox(Map(
    "MEM_ADDR_BITS" -> p.NUM_ADDR_BITS.toString(),
    "MEM_DATA_BITS" -> p.NUM_DATA_BITS.toString()
    )){
 
  val io = IO(new Bundle {
    
  })
}

object GenericSramByteEn {
}