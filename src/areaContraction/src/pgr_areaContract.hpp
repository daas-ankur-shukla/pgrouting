/*PGR-GNU*****************************************************************
File: pgr_contract.hpp

Generated with Template by:
Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

Function's developer:
Copyright (c) 2016 Ankur Shukla
Mail: work.ankurshukla@gmail.com

------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

********************************************************************PGR-GNU*/

#ifndef SRC_AREACONTRACTION_SRC_PGR_AREACONTRACT_HPP_
#define SRC_AREACONTRACTION_SRC_PGR_AREACONTRACT_HPP_
#pragma once

#include <deque>
#include <vector>
#include "cpp_common/pgr_assert.h"


namespace pgrouting {
namespace areacontraction {


template < class G >
class Pgr_contract {
    typedef typename G::V V;

public:
  Pgr_contract(
    G &graph,
    Identifiers<V> borderVertices,
    std::vector<pgrouting::CH_edge> &shortcut_edges,
    std::ostringstream& debug) {

    }
  }
}
}