// choose one of the two versions.
#define FINDROOT findroot

/* from Newman and Ziff. Their 2000 paper mentions that "modern" compilers treat this
   efficiently; but dissasembling output from gcc 4.6.3 shows that the recursive
   function call is not optimized away with -O3.
   We instead use the explicit loop below.
*/
int findrootr(const int i, int *ptr) {
  if (ptr[i]<0) return i;
  return ptr[i] = findrootr(ptr[i], ptr);
}

/*  
    This gives the same result, but uses a loop and even the first call is inlined.
 */
inline int findroot(int i, int *ptr) {
  int c;
  for(;;) {
    c = ptr[i];
    if ( c < 0 ) break;
    ptr[i] = c; // compress path
    i = c;
  }
  return i;
}

inline void hk_tally(int *clusters, int *dist, int Lx, int Ly, int *max_c, int *num_c) {
  int i;
  const int N = Lx * Ly;
  const int empty = -Lx*Ly - 1;
  int c;
  int imax_c = 0;
  int inum_c = 0;
  for(i=0;i<N;i++) dist[i] = 0;
  for(i=0;i<N;i++) {
    c = clusters[i];
    //    printf("%d %d\n", i,c);
    if ( c < 0 && c != empty ) {
      if (-c > imax_c) imax_c = -c;
      dist[ -c -1]++;
      inum_c++;
    }
  }
  *max_c = imax_c;
  *num_c = inum_c;
} 

#define HKIND(i,j) ((i)*Lx+(j))
#define CHK(i,j) clusters[HKIND((i),(j))]

#define HK_CLUSTERS hk_clusters_int
#define HK_CLUSTERS_TALLY hk_clusters_tally_int
#define SITES_T int
#include "hk_types.c"
#undef HK_CLUSTERS
#undef HK_CLUSTERS_TALLY
#undef SITES_T

#define HK_CLUSTERS hk_clusters_char
#define HK_CLUSTERS_TALLY hk_clusters_tally_char
#define SITES_T char
#include "hk_types.c"
#undef HK_CLUSTERS
#undef HK_CLUSTERS_TALLY
#undef SITES_T


#define HK_CLUSTERS hk_clusters_double
#define HK_CLUSTERS_TALLY hk_clusters_tally_double
#define SITES_T double
#include "hk_types.c"
#undef HK_CLUSTERS
#undef HK_CLUSTERS_TALLY
#undef SITES_T

