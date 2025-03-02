//////////////////////////////////////////////////////////////////////////
// Copyright 2021 The Aerospace Corporation
//
// This file is part of SatCat5.
//
// SatCat5 is free software: you can redistribute it and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// SatCat5 is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with SatCat5.  If not, see <https://www.gnu.org/licenses/>.
//////////////////////////////////////////////////////////////////////////
// "Writeable" I/O interface core definitions
//
// Define the abstract "Writeable" interface. Anything that accepts a
// byte-stream, with or without packets, should usually implement this
// interface to allow flexiable reconnection with other SatCat5 tools.
//

#pragma once

#include <satcat5/types.h>

namespace satcat5 {
    namespace io {
        // Generic interface for writing data to a device or buffer.
        class Writeable {
        public:
            // How many bytes can be written without blocking?
            // (Child objects MUST override this method.)
            virtual unsigned get_write_space() const = 0;

            // Write various data types.
            // (Child MAY override "write_bytes" as needed for performance.)
            void write_u8(u8 data);
            void write_u16(u16 data);
            void write_u32(u32 data);
            void write_u64(u64 data);
            void write_s8(s8 data);
            void write_s16(s16 data);
            void write_s32(s32 data);
            void write_s64(s64 data);
            void write_f32(float data);
            void write_f64(double data);
            void write_str(const char* str);
            virtual void write_bytes(unsigned nbytes, const void* src);

            // Mark end of frame and release temporary working data.
            // Returns true if successful, false on error.
            // (Child objects SHOULD override this method to mark frame bounds.)
            virtual bool write_finalize();

            // If possible, abort the current partially-written packet.
            // (Child objects SHOULD override this method if it is practical
            //  to prevent in-progress data from being relayed downstream.)
            virtual void write_abort();

            // Templated wrapper for any object with the following method:
            //  void write_to(satcat5::io::Writeable* wr) const;
            template <class T> inline void write_obj(const T& obj)
                {obj.write_to(this);}

        protected:
            friend WriteableRedirect;

            // Only children should create or destroy the base class.
            Writeable() {}
            ~Writeable() {}

            // Write the next byte to the underlying buffer or device.
            // (Child objects MUST override this method.)
            virtual void write_next(u8 data) = 0;

            // Optional error handling for write overflow.
            // (Child objects MAY override this method for error handling.)
            virtual void write_overflow();
        };

        // Ephemeral "Writeable" interface for a simple array.
        class ArrayWrite : public satcat5::io::Writeable {
        public:
            ArrayWrite(void* dst, unsigned len);
            unsigned get_write_space() const override;
            bool write_finalize() override;
            inline unsigned written_len() const {return m_wrlen;}
        private:
            void write_next(u8 data) override;
            u8* const       m_dst;
            const unsigned  m_len;
            unsigned        m_wridx;
            unsigned        m_wrlen;
        };

        // Wrapper class used to gain indirect access to "Writeable::write_next"
        // method, which is required for certain types of I/O adapters.
        class WriteableRedirect : public satcat5::io::Writeable {
        public:
            unsigned get_write_space() const override;
            void write_abort() override;
            void write_bytes(unsigned nbytes, const void* src) override;
            bool write_finalize() override;
        protected:
            explicit WriteableRedirect(satcat5::io::Writeable* dst);
            ~WriteableRedirect() {}
            void write_next(u8 data) override;
            void write_overflow() override;
        private:
            satcat5::io::Writeable* const m_dst;
        };
    }
}
