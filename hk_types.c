
inline void HK_CLUSTERS(int *clusters, SITES_T *sites, int Lx, int Ly, int closed_site) {
  int N = Lx*Ly;
  int empty = -N-1;
  int i,j,up=0,left=0, cup, cleft;
  for(i=0;i<N;i++) clusters[i] = empty;
  for(i=0;i<Ly;i++) {
    for(j=0;j<Lx;j++) {
      //      if ( sites[HKIND(i,j)] == open_site ) {
      if ( sites[HKIND(i,j)] != closed_site ) {
        if ( i > 0 )  {  // could optimize to get rid of this check
          up = FINDROOT(HKIND(i-1,j),clusters);
          cup = clusters[up];
        }
        else cup = empty;
        if ( j > 0 ) {
          left = FINDROOT(HKIND(i,j-1),clusters);
          cleft = clusters[left];
        }
        else cleft = empty;
        if ( cup != empty ) {
          if ( cleft != empty  && up != left ) {
            if ( clusters[left] < clusters[up] ) {  // left is bigger than up
              clusters[left] = clusters[left] + clusters[up] - 1;
              clusters[up] = left;
              CHK(i,j) = left;
            }
            else {
              clusters[up] = clusters[left] + clusters[up] - 1;
              clusters[left] = up;
              CHK(i,j) = up;
            }
          }
          else {
            clusters[up] = clusters[up] - 1;
            CHK(i,j) = up;
          }
        }
        else if (cleft != empty ) {
          clusters[left] = clusters[left] - 1;
          CHK(i,j) = left;
        }
        else {
          CHK(i,j) = -1;
        }
      }
    }
  }
}

/*
  This is convenient, but may be inefficient if cluster counting is done
  several times becauses C<sites> is allocated and deallocated on each call.
*/
inline void  HK_CLUSTERS_TALLY (SITES_T *sites, int *dist, int Lx, int Ly, int closed_site, int *max_c, int *num_c) {
  const int N = Lx * Ly;
  int *clusters;
  clusters = (int *) malloc(N*sizeof(int));
  HK_CLUSTERS (clusters, sites, Lx, Ly, closed_site);
  hk_tally(clusters, dist, Lx, Ly, max_c, num_c);
  free(clusters);
}

