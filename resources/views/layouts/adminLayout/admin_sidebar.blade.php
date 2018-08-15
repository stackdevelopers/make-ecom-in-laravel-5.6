<!--sidebar-menu-->
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li class="active"><a href="index.html"><i class="icon icon-home"></i> <span>Dashboard</span></a> </li>
    <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Categories</span> <span class="label label-important">2</span></a>
      <ul>
        <li><a href="{{ url('/admin/add-category')}}">Add Category</a></li>
        <li><a href="{{ url('/admin/view-categories')}}">View Categories</a></li>
      </ul>
    </li>
     <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Products</span> <span class="label label-important">2</span></a>
      <ul>
        <li><a href="{{ url('/admin/add-product')}}">Add Product</a></li>
        <li><a href="{{ url('/admin/view-products')}}">View Products</a></li>
      </ul>
    </li>
    <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Coupons</span> <span class="label label-important">2</span></a>
      <ul>
        <li><a href="{{ url('/admin/add-coupon')}}">Add Coupon</a></li>
        <li><a href="{{ url('/admin/view-coupons')}}">View Coupons</a></li>
      </ul>
    </li>
    <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Banners</span> <span class="label label-important">2</span></a>
      <ul>
        <li><a href="{{ url('/admin/add-banner')}}">Add Banner</a></li>
        <li><a href="{{ url('/admin/view-banners')}}">View Banners</a></li>
      </ul>
    </li>
  </ul>
</div>
<!--sidebar-menu-->