/*PGR
File: one_to_one_dijkstra_driver.cpp

Generated with Template by:
Copyright (c) 2015 pgRouting developers

Function's developer: 
Copyright (c) 2015 Celia Virginia Vergara Castillo


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

*/


#ifdef __MINGW32__
#include <winsock2.h>
#include <windows.h>
#endif


#include <sstream>
#include <deque>
#include <vector>
#include "./pgr_dijkstra.hpp"
#include "./one_to_one_dijkstra_driver.h"

// #define DEBUG

extern "C" {
#include "postgres.h"
#include "./../../common/src/pgr_types.h"
#include "./../../common/src/postgres_connection.h"
}

// CREATE OR REPLACE FUNCTION pgr_dijkstra(sql text, start_vids BIGINT, end_vid BIGINT, directed BOOLEAN default true,
void
do_pgr_one_to_one_dijkstra(
        pgr_edge_t  *data_edges,
        size_t total_tuples,
        int64_t start_vid,
        int64_t end_vid,
        bool directed,
        General_path_element_t **return_tuples,
        size_t *return_count,
        char ** err_msg){
  std::ostringstream log;
  try {

    if (total_tuples == 1) {
      log << "Requiered: more than one tuple\n";
      (*return_tuples) = NULL;
      (*return_count) = 0;
      *err_msg = strdup(log.str().c_str());
      return;
    }

    graphType gType = directed? DIRECTED: UNDIRECTED;
    const int initial_size = total_tuples;

    Path path;

    if (directed) {
      log << "Working with directed Graph\n";
      Pgr_base_graph< DirectedGraph > digraph(gType, initial_size);
      digraph.graph_insert_data(data_edges, total_tuples);
      pgr_dijkstra(digraph, path, start_vid, end_vid);
    } else {
      log << "Working with Undirected Graph\n";
      Pgr_base_graph< UndirectedGraph > undigraph(gType, initial_size);
      undigraph.graph_insert_data(data_edges, total_tuples);
      pgr_dijkstra(undigraph, path, start_vid, end_vid);
    }

    size_t count(path.size());

    if (count == 0) {
      (*return_tuples) = NULL;
      (*return_count) = 0;
      log << 
        "No paths found between Starting and any of the Ending vertices\n";
      *err_msg = strdup(log.str().c_str());
      return;
    }

    // get the space required to store all the paths
    (*return_tuples) = get_memory(count, (*return_tuples));
    log << "Converting a set of paths into the tuples\n";
    size_t sequence = 0;
    path.generate_postgres_data(return_tuples, sequence);
    (*return_count) = sequence;

    #ifndef DEBUG
      *err_msg = strdup("OK");
    #else
      *err_msg = strdup(log.str().c_str());
    #endif

    return;
  } catch ( ... ) {
    log << "Caught unknown expection!\n";
    *err_msg = strdup(log.str().c_str());
    return;
  }
}





