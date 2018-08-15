<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;
use Auth;
use Session;
use Image;
use App\Category;
use App\Product;
use App\ProductsAttribute;
use App\ProductsImage;
use App\Coupon;
use DB;

class ProductsController extends Controller
{
	public function addProduct(Request $request){

		if($request->isMethod('post')){
			$data = $request->all();
			//echo "<pre>"; print_r($data); die;

			$product = new Product;
			$product->category_id = $data['category_id'];
			$product->product_name = $data['product_name'];
			$product->product_code = $data['product_code'];
			$product->product_color = $data['product_color'];
			if(!empty($data['description'])){
				$product->description = $data['description'];
			}else{
				$product->description = '';	
			}
            if(!empty($data['care'])){
                $product->care = $data['care'];
            }else{
                $product->care = ''; 
            }
            if(empty($data['status'])){
                $status='0';
            }else{
                $status='1';
            }
			$product->price = $data['price'];

			// Upload Image
            if($request->hasFile('image')){
            	$image_tmp = Input::file('image');
                if ($image_tmp->isValid()) {
                    // Upload Images after Resize
                    $extension = $image_tmp->getClientOriginalExtension();
	                $fileName = rand(111,99999).'.'.$extension;
                    $large_image_path = 'images/backend_images/product/large'.'/'.$fileName;
                    $medium_image_path = 'images/backend_images/product/medium'.'/'.$fileName;  
                    $small_image_path = 'images/backend_images/product/small'.'/'.$fileName;  

	                Image::make($image_tmp)->save($large_image_path);
 					Image::make($image_tmp)->resize(600, 600)->save($medium_image_path);
     				Image::make($image_tmp)->resize(300, 300)->save($small_image_path);

     				$product->image = $fileName; 

                }
            }

            $product->status = $status;
			$product->save();
			return redirect()->back()->with('flash_message_success', 'Product has been added successfully');
		}

		$categories = Category::where(['parent_id' => 0])->get();

		$categories_drop_down = "<option value='' selected disabled>Select</option>";
		foreach($categories as $cat){
			$categories_drop_down .= "<option value='".$cat->id."'>".$cat->name."</option>";
			$sub_categories = Category::where(['parent_id' => $cat->id])->get();
			foreach($sub_categories as $sub_cat){
				$categories_drop_down .= "<option value='".$sub_cat->id."'>&nbsp;&nbsp;--&nbsp;".$sub_cat->name."</option>";	
			}	
		}

		//echo "<pre>"; print_r($categories_drop_down); die;

		return view('admin.products.add_product')->with(compact('categories_drop_down'));
	}  

	public function editProduct(Request $request,$id=null){

		if($request->isMethod('post')){
			$data = $request->all();
			//echo "<pre>"; print_r($data); die;

            if(empty($data['status'])){
                $status='0';
            }else{
                $status='1';
            }

			// Upload Image
            if($request->hasFile('image')){
            	$image_tmp = Input::file('image');
                if ($image_tmp->isValid()) {
                    // Upload Images after Resize
                    $extension = $image_tmp->getClientOriginalExtension();
	                $fileName = rand(111,99999).'.'.$extension;
                    $large_image_path = 'images/backend_images/product/large'.'/'.$fileName;
                    $medium_image_path = 'images/backend_images/product/medium'.'/'.$fileName;  
                    $small_image_path = 'images/backend_images/product/small'.'/'.$fileName;  

	                Image::make($image_tmp)->save($large_image_path);
 					Image::make($image_tmp)->resize(600, 600)->save($medium_image_path);
     				Image::make($image_tmp)->resize(300, 300)->save($small_image_path);

                }
            }else if(!empty($data['current_image'])){
            	$fileName = $data['current_image'];
            }else{
            	$fileName = '';
            }

            if(empty($data['description'])){
            	$data['description'] = '';
            }

            if(empty($data['care'])){
                $data['care'] = '';
            }

			Product::where(['id'=>$id])->update(['status'=>$status,'category_id'=>$data['category_id'],'product_name'=>$data['product_name'],
				'product_code'=>$data['product_code'],'product_color'=>$data['product_color'],'description'=>$data['description'],'care'=>$data['care'],'price'=>$data['price'],'image'=>$fileName]);
		
			return redirect()->back()->with('flash_message_success', 'Product has been edited successfully');
		}

		// Get Product Details start //
		$productDetails = Product::where(['id'=>$id])->first();
		// Get Product Details End //

		// Categories drop down start //
		$categories = Category::where(['parent_id' => 0])->get();

		$categories_drop_down = "<option value='' disabled>Select</option>";
		foreach($categories as $cat){
			if($cat->id==$productDetails->category_id){
				$selected = "selected";
			}else{
				$selected = "";
			}
			$categories_drop_down .= "<option value='".$cat->id."' ".$selected.">".$cat->name."</option>";
			$sub_categories = Category::where(['parent_id' => $cat->id])->get();
			foreach($sub_categories as $sub_cat){
				if($sub_cat->id==$productDetails->category_id){
					$selected = "selected";
				}else{
					$selected = "";
				}
				$categories_drop_down .= "<option value='".$sub_cat->id."' ".$selected.">&nbsp;&nbsp;--&nbsp;".$sub_cat->name."</option>";	
			}	
		}
		// Categories drop down end //

		return view('admin.products.edit_product')->with(compact('productDetails','categories_drop_down'));
	} 

	public function deleteProductImage($id=null){

		// Get Product Image
		$productImage = Product::where('id',$id)->first();

		// Get Product Image Paths
		$large_image_path = 'images/backend_images/product/large/';
		$medium_image_path = 'images/backend_images/product/medium/';
		$small_image_path = 'images/backend_images/product/small/';

		// Delete Large Image if not exists in Folder
        if(file_exists($large_image_path.$productImage->image)){
            unlink($large_image_path.$productImage->image);
        }

        // Delete Medium Image if not exists in Folder
        if(file_exists($medium_image_path.$productImage->image)){
            unlink($medium_image_path.$productImage->image);
        }

        // Delete Small Image if not exists in Folder
        if(file_exists($small_image_path.$productImage->image)){
            unlink($small_image_path.$productImage->image);
        }

        // Delete Image from Products table
        Product::where(['id'=>$id])->update(['image'=>'']);

        return redirect()->back()->with('flash_message_success', 'Product image has been deleted successfully');
	}

    public function deleteProductAltImage($id=null){

        // Get Product Image
        $productImage = ProductsImage::where('id',$id)->first();

        // Get Product Image Paths
        $large_image_path = 'images/backend_images/product/large/';
        $medium_image_path = 'images/backend_images/product/medium/';
        $small_image_path = 'images/backend_images/product/small/';

        // Delete Large Image if not exists in Folder
        if(file_exists($large_image_path.$productImage->image)){
            unlink($large_image_path.$productImage->image);
        }

        // Delete Medium Image if not exists in Folder
        if(file_exists($medium_image_path.$productImage->image)){
            unlink($medium_image_path.$productImage->image);
        }

        // Delete Small Image if not exists in Folder
        if(file_exists($small_image_path.$productImage->image)){
            unlink($small_image_path.$productImage->image);
        }

        // Delete Image from Products Images table
        ProductsImage::where(['id'=>$id])->delete();

        return redirect()->back()->with('flash_message_success', 'Product alternate mage has been deleted successfully');
    }

	public function viewProducts(Request $request){
		$products = Product::get();
		foreach($products as $key => $val){
			$category_name = Category::where(['id' => $val->category_id])->first();
			$products[$key]->category_name = $category_name->name;
		}
		$products = json_decode(json_encode($products));
		//echo "<pre>"; print_r($products); die;
		return view('admin.products.view_products')->with(compact('products'));
	}

	public function deleteProduct($id = null){
        Product::where(['id'=>$id])->delete();
        return redirect()->back()->with('flash_message_success', 'Product has been deleted successfully');
    }

    public function deleteAttribute($id = null){
        ProductsAttribute::where(['id'=>$id])->delete();
        return redirect()->back()->with('flash_message_success', 'Product Attribute has been deleted successfully');
    }

    public function addAttributes(Request $request, $id=null){
        $productDetails = Product::with('attributes')->where(['id' => $id])->first();
        //$productDetails = json_decode(json_encode($productDetails));
        /*echo "<pre>"; print_r($productDetails); die;*/

        $categoryDetails = Category::where(['id'=>$productDetails->category_id])->first();
        $category_name = $categoryDetails->name;

        if($request->isMethod('post')){
            $data = $request->all();
            //echo "<pre>"; print_r($data); die;

            foreach($data['sku'] as $key => $val){
                if(!empty($val)){
                    $attrCountSKU = ProductsAttribute::where(['sku'=>$val])->count();
                    if($attrCountSKU>0){
                        return redirect('admin/add-attributes/'.$id)->with('flash_message_error', 'SKU already exists. Please add another SKU.');    
                    }
                    $attrCountSizes = ProductsAttribute::where(['product_id'=>$id,'size'=>$data['size'][$key]])->count();
                    if($attrCountSizes>0){
                        return redirect('admin/add-attributes/'.$id)->with('flash_message_error', 'Attribute already exists. Please add another Attribute.');    
                    }
                    $attr = new ProductsAttribute;
                    $attr->product_id = $id;
                    $attr->sku = $val;
                    $attr->size = $data['size'][$key];
                    $attr->price = $data['price'][$key];
                    $attr->stock = $data['stock'][$key];
                    $attr->save();
                }
            }
            return redirect('admin/add-attributes/'.$id)->with('flash_message_success', 'Product Attributes has been added successfully');

        }

        $title = "Add Attributes";
        return view('admin.products.add_attributes')->with(compact('title','productDetails','category_name'));
    }

    public function editAttributes(Request $request, $id=null){
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            foreach($data['idAttr'] as $key=> $attr){
                if(!empty($attr)){
                    ProductsAttribute::where(['id' => $data['idAttr'][$key]])->update(['price' => $data['price'][$key], 'stock' => $data['stock'][$key]]);
                }
            }
            return redirect('admin/add-attributes/'.$id)->with('flash_message_success', 'Product Attributes has been updated successfully');
        }
    }

    public function addImages(Request $request, $id=null){
        $productDetails = Product::where(['id' => $id])->first();

        $categoryDetails = Category::where(['id'=>$productDetails->category_id])->first();
        $category_name = $categoryDetails->name;

        if($request->isMethod('post')){
            $data = $request->all();
            if ($request->hasFile('image')) {
                $files = $request->file('image');
                foreach($files as $file){
                    // Upload Images after Resize
                    $image = new ProductsImage;
                    $extension = $file->getClientOriginalExtension();
                    $fileName = rand(111,99999).'.'.$extension;
                    $large_image_path = 'images/backend_images/product/large'.'/'.$fileName;
                    $medium_image_path = 'images/backend_images/product/medium'.'/'.$fileName;  
                    $small_image_path = 'images/backend_images/product/small'.'/'.$fileName;  
                    Image::make($file)->save($large_image_path);
                    Image::make($file)->resize(600, 600)->save($medium_image_path);
                    Image::make($file)->resize(300, 300)->save($small_image_path);
                    $image->image = $fileName;  
                    $image->product_id = $data['product_id'];
                    $image->save();
                }   
            }

            return redirect('admin/add-images/'.$id)->with('flash_message_success', 'Product Images has been added successfully');

        }

        $productImages = ProductsImage::where(['product_id' => $id])->orderBy('id','DESC')->get();

        $title = "Add Images";
        return view('admin.products.add_images')->with(compact('title','productDetails','category_name','productImages'));
    }

    public function products($url=null){

    	// Show 404 Page if Category does not exists
    	$categoryCount = Category::where(['url'=>$url,'status'=>1])->count();
    	if($categoryCount==0){
    		abort(404);
    	}

    	$categories = Category::with('categories')->where(['parent_id' => 0])->get();

    	$categoryDetails = Category::where(['url'=>$url])->first();
    	if($categoryDetails->parent_id==0){
    		$subCategories = Category::where(['parent_id'=>$categoryDetails->id])->get();
    		$subCategories = json_decode(json_encode($subCategories));
    		foreach($subCategories as $subcat){
    			$cat_ids[] = $subcat->id;
    		}
    		$productsAll = Product::whereIn('category_id', $cat_ids)->where('status','1')->get();
    	}else{
    		$productsAll = Product::where(['category_id'=>$categoryDetails->id])->where('status','1')->get();	
    	}
    	
    	return view('products.listing')->with(compact('categories','productsAll','categoryDetails'));

    }

    public function product($id = null){

        // Show 404 Page if Product is disabled
        $productCount = Product::where(['id'=>$id,'status'=>1])->count();
        if($productCount==0){
            abort(404);
        }

        // Get Product Details
        $productDetails = Product::with('attributes')->where('id',$id)->first();
        $relatedProducts = Product::where('id','!=',$id)->where(['category_id' => $productDetails->category_id])->get();

        /*foreach($relatedProducts->chunk(3) as $chunk){
            foreach($chunk as $item){
                echo $item; echo "<br>"; 
            }   
            echo "<br><br><br>";
        }*/
        
        // Get Product Alt Images
        $productAltImages = ProductsImage::where('product_id',$id)->get();
        /*$productAltImages = json_decode(json_encode($productAltImages));
        echo "<pre>"; print_r($productAltImages); die;*/
        $categories = Category::with('categories')->where(['parent_id' => 0])->get();

        $total_stock = ProductsAttribute::where('product_id',$id)->sum('stock');

        return view('products.detail')->with(compact('productDetails','categories','productAltImages','total_stock','relatedProducts'));
    }

    public function getProductPrice(Request $request){
        $data = $request->all(); 
        $proArr = explode("-",$data['idsize']);
        $proAttr = ProductsAttribute::where(['product_id'=>$proArr[0],'size'=>$proArr[1]])->first();
        echo $proAttr->price; 
        echo "#";
        echo $proAttr->stock; 
    }


    public function addtocart(Request $request){

        Session::forget('CouponAmount');
        Session::forget('CouponCode');

        $data = $request->all();
        /*echo "<pre>"; print_r($data); die;*/
        if(empty($data['user_email'])){
            $data['user_email'] = '';    
        }

        $session_id = Session::get('session_id');
        if(!isset($session_id)){
            $session_id = str_random(40);
            Session::put('session_id',$session_id);
        }

        $countProducts = DB::table('cart')->where(['product_id' => $data['product_id'],'product_color' => $data['product_color'],'size' => $data['size'],'session_id' => $session_id])->count();
        if($countProducts>0){
            return redirect()->back()->with('flash_message_error','Product already exist in Cart!');
        }

        $sizeIDArr = explode('-',$data['size']);
        $product_size = $sizeIDArr[1];

        $getSKU = ProductsAttribute::select('sku')->where(['product_id' => $data['product_id'], 'size' => $product_size])->first();
                
        DB::table('cart')
        ->insert(['product_id' => $data['product_id'],'product_name' => $data['product_name'],
            'product_code' => $getSKU['sku'],'product_color' => $data['product_color'],
            'price' => $data['price'],'size' => $product_size,'quantity' => $data['quantity'],'user_email' => $data['user_email'],'session_id' => $session_id]);

        return redirect('cart')->with('flash_message_success','Product has been added in Cart!');

    }    

    public function cart(){       
        $session_id = Session::get('session_id');
        $userCart = DB::table('cart')->where(['session_id' => $session_id])->get();
        foreach($userCart as $key => $product){
            $productDetails = Product::where('id',$product->product_id)->first();
            $userCart[$key]->image = $productDetails->image;
        }
        /*echo "<pre>"; print_r($userCart); die;*/
        return view('products.cart')->with(compact('userCart'));
    }

    public function updateCartQuantity($id=null,$quantity=null){
        Session::forget('CouponAmount');
        Session::forget('CouponCode');
        $getProductSKU = DB::table('cart')->select('product_code','quantity')->where('id',$id)->first();
        $getProductStock = ProductsAttribute::where('sku',$getProductSKU->product_code)->first();
        $updated_quantity = $getProductSKU->quantity+$quantity;
        if($getProductStock->stock>=$updated_quantity){
            DB::table('cart')->where('id',$id)->increment('quantity',$quantity); 
            return redirect('cart')->with('flash_message_success','Product Quantity has been updated in Cart!');   
        }else{
            return redirect('cart')->with('flash_message_error','Required Product Quantity is not available!');    
        }
    }

    public function deleteCartProduct($id=null){
        Session::forget('CouponAmount');
        Session::forget('CouponCode');
        DB::table('cart')->where('id',$id)->delete();
        return redirect('cart')->with('flash_message_success','Product has been deleted in Cart!');
    }

    public function applyCoupon(Request $request){

        Session::forget('CouponAmount');
        Session::forget('CouponCode');

        $data = $request->all();
        /*echo "<pre>"; print_r($data); die;*/
        $couponCount = Coupon::where('coupon_code',$data['coupon_code'])->count();
        if($couponCount == 0){
            return redirect()->back()->with('flash_message_error','This coupon does not exists!');
        }else{
            // with perform other checks like Active/Inactive, Expiry date..

            // Get Coupon Details
            $couponDetails = Coupon::where('coupon_code',$data['coupon_code'])->first();
            
            // If coupon is Inactive
            if($couponDetails->status==0){
                return redirect()->back()->with('flash_message_error','This coupon is not active!');
            }

            // If coupon is Expired
            $expiry_date = $couponDetails->expiry_date;
            $current_date = date('Y-m-d');
            if($expiry_date < $current_date){
                return redirect()->back()->with('flash_message_error','This coupon is expired!');
            }

            // Coupon is Valid for Discount

            // Get Cart Total Amount
            $session_id = Session::get('session_id');
            $userCart = DB::table('cart')->where(['session_id' => $session_id])->get();
            $total_amount = 0;
            foreach($userCart as $item){
               $total_amount = $total_amount + ($item->price * $item->quantity);
            }

            // Check if amount type is Fixed or Percentage
            if($couponDetails->amount_type=="Fixed"){
                $couponAmount = $couponDetails->amount;
            }else{
                $couponAmount = $total_amount * ($couponDetails->amount/100);
            }

            // Add Coupon Code & Amount in Session
            Session::put('CouponAmount',$couponAmount);
            Session::put('CouponCode',$data['coupon_code']);

            return redirect()->back()->with('flash_message_success','Coupon code successfully
                applied. You are availing discount!');

        }
    }

}
