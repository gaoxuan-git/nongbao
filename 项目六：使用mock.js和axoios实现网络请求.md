# ***\*项目六\*******\*：\*******\*使用mock.js和axoios实现网络请求\****

***\*【项目介绍】\****

本章任务我们完成了知识课堂的增删改、批量操作功能，并使用mock.js模拟后台接口，使用axios完成接口调用，作为前端核心知识技能，我们需要掌握axios的各种请求方式和参数封装，并需要学会如何解析请求返回的数据，并进行组件绑定。最终的效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps22.jpg) 

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps23.jpg) 

​                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

***\*【任务安排】\****

任务一 使用插槽完善知识管理界面

任务二 数据请求获取与增删改操作

***\*【学习目标】\****

l 深入理解Vue插槽机制：掌握默认插槽、具名插槽、作用域插槽的定义与使用场景，能够灵活定制组件内容。

l 熟练使用Axios进行网络请求：包括GET/POST请求配置、参数传递、拦截器使用、错误处理等。

l 掌握Mock.js模拟后端接口：能够定义数据模板、拦截请求并返回模拟数据，实现前后端分离开发。

l 综合运用Element Plus组件：熟练使用el-table、el-form、el-dialog等组件，实现数据展示、表单提交、弹窗交互等功能。

l 理解组件生命周期钩子：掌握onMounted等钩子在数据请求中的应用，确保数据加载时机合理。

l 实现动态数据绑定与响应式更新：通过Vue的响应式系统，确保数据变化后界面自动刷新。

l 处理复杂业务逻辑：包括表单验证、批量操作、状态管理等，提升代码可维护性。

 

***\*6.1 任务一 使用插槽完善知识\*******\*管理\*******\*页面\****

***\*【任务描述】\****

在知识管理专家列表中，我们需要显示每条记录的发布状态（如已发布、未发布）和是否推荐的状态，并根据这些状态动态地在操作列中显示相应的按钮（例如：编辑、删除、发布、取消发布等）。在项目三中我们是通过直接在表格对象属性上进行判断并动态创建标签元素来实现，这种方法不仅增加了代码量，还使得逻辑变得复杂不易维护。

本任务旨在利用 作用域插槽（Scoped Slots） 来简化这一功能的实现，从而提高代码的可读性和维护性。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps24.jpg) 

***\*【任务分析】\****

插槽是 Vue.js 提供的一种机制，用于将内容分发到子组件内部，允许父组件向子组件传递模板片段。通常情况下，插槽用于实现父子组件之间的内容传递。然而，在实际开发中，插槽的应用远不止于此，它还可以用于定制第三方组件库（如 Element Plus）中复杂组件的显示内容。

在本任务中，我们将使用 作用域插槽（Scoped Slot） 来自定义 Element Plus 中 <el-table> 组件的某一列（如“操作”列）的渲染方式。通过作用域插槽，我们可以访问表格每一行的数据，并根据该行数据的状态（如发布状态、是否推荐等），动态渲染不同的操作按钮（如“发布”、“取消发布”、“推荐”、“取消推荐”等），从而实现更灵活、更清晰的界面展示与逻辑控制。

 

***\*【知识准备】\****

***\*6.1.1 插槽\****

Vue 提供了插槽（Slot）机制，作为组件创建者与使用者之间的一种桥梁。插槽允许组件的创建者在设计组件时留出不确定的部分，这些部分可以由组件的使用者根据具体需求进行填充。换句话说，插槽就像是为组件使用者预留的占位符，允许他们在组件内部展示特定的内容。通过插槽，不仅使组件变得更加灵活和具有复用性，还能够实现内容与布局的有效分离。插槽的作用如下：

l 增强组件的可扩展性：允许外部内容插入到组件内部的指定位置，使得组件可以根据不同的需求进行扩展。

l 提升组件的复用性：在不同的使用场景下，可以通过传递不同的内容给同一个组件，从而提高组件的通用性和灵活性。

l 实现布局与内容的分离：组件可以专注于提供稳定的布局结构，而将具体内容的填充交给使用者，这样既简化了组件的设计，也增加了其适应不同内容的能力。

简而言之，插槽是 Vue 中用于内容分发的一种强大机制，它允许开发者在组件模板中定义可替换的部分，从而使组件更加灵活、更易于组合和复用。这种机制极大地增强了开发效率，同时也支持了更高层次的代码重用和定制化需求。

插槽需要定义后才能使用，下面对定义插槽和使用插槽分别进行讲解。

***\*1\**** ***\*定义插槽\****

在封装组件时，可以通过<slot>标签定义插槽，从而在组件中预留占位符。假设项目中有一个MyButton组件，在MyButton组件中定义插槽的示例代码如下。

<template> <button>  <slot></slot> </button></template>

在<slot>标签内可以添加一些内容作为插槽的默认内容。如果组件的使用者没有为插槽提供任何内容，则默认内容生效；如果组件的使用者为插槽提供了插槽内容，则该插槽内容会取代默认内容。

另外，如果一个组件没有预留任何插槽，则组件的使用者提供的任何插槽内容都会不起作用。

***\*2 使用插槽\****

使用插槽即在父组件中使用子组件的插槽，在使用时需要将子组件写成双标签的形式，在双标签内提供插槽内容。例如，父组件中使用MyButton组件的插槽的示例代码如下。

<template>  <MyButton>   按钮  </MyButton></template>

因为插槽内容是在父组件模板中定义的，所以在插槽内容中可以访问到父组件的数据。插槽内容可以是任意合法的模板内容，不局限于文本。例如，可以使用多个元素或者组件作为插槽内容，示例代码如下。

<MyButton> <span style="color: yellow;">按钮</span> <MyLeft />  <!-- 可以是一个自定义组件 --></MyButton>

***\*3\**** ***\*插槽的\*******\*具体\*******\*使用方法\****

步骤1：创建src\components\SlotSubComponent.vue文件，用于展示子组件的相关内容。

<template> <h3>子组件</h3> <slot>默认内容</slot></template>

这里，<slot>标签标记了可以被外部内容替换的地方。如果没有提供任何内容，“默认内容”将被显示。

步骤2：创建src\components\MySlot.vue文件，用于展示插槽的相关内容。

<template> 父组件-----{{ message }} <hr> <SlotSubComponent>  <p>{{ message }}</p> </SlotSubComponent></template><script setup>import SlotSubComponent from './SlotSubComponent.vue'const message = '这是组件的使用者自定义的内容'</script>

步骤3：修改src\main.ts文件，切换页面中显示的组件。

import App from './components/MySlot.vue'

保存上述代码后，在浏览器中访问，使用插槽后的页面效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps25.jpg) 

上面的代码中，因为<SlotSubComponent>在使用时传入了内容，所以会替换掉子组件<slot>中的内容。

***\*如果要显示\*******\*插槽的默认内容\*******\*，\****可将SlotSubComponent组件中的<p>{{ message }}</p>注释掉。保存上述代码后，插槽提供默认内容的页面效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps26.jpg) 

 

***\*6.1.2 具名插槽\****

在Vue中当需要定义多个插槽时，可以通过具名插槽来区分不同的插槽。具名插槽是给每一个插槽定义一个名称，这样就可以在对应名称的插槽中提供对应的数据了。

插槽通过<slot>标签来定义，<slot>标签有一个name属性，用于给各个插槽分配唯一的名称，以确定每一处要渲染的内容。添加name属性的<slot>标签可用来定义具名插槽。

定义具名插槽的语法格式如下。

<slot name="插槽名称"></slot>

在父组件中，如果要把内容填充到指定名称的插槽中，可以通过一个包含v-slot指令的<template>标签来实现，语法格式如下。

<组件名> <template v-slot:插槽名称></template></组件名>

与v-on和v-bind类似，v-slot也有简写形式，即把v-slot:替换为#。例如，v-slot:title可以简写为#title。

具名插槽的使用方式如下：

步骤1：创建src\components\ArticleInfo.vue文件，用于展示文章内容模板。

<template> <div class="article-container">  <div class="header-box"><slot name="header"></slot></div>  <div class="content-box"><slot name="content"></slot></div>  <div class="footer-box"><slot name="footer"></slot></div> </div></template><style>.article-container > div { border: 1px solid black; }</style>

步骤2：创建src\components\MyArticle.vue文件，用于提供文章数据，在MyArticle组件中导入并使用ArticleInfo组件，并在<ArticleInfo>标签中为不同插槽添加不同的信息。

<template> <ArticleInfo>  <template v-slot:header><p>这是文章的头部区域</p></template>  <template v-slot:content><p>这是文章的内容区域</p></template>  <template #footer><p>这是文章的尾部区域</p></template> </ArticleInfo></template><script setup>import ArticleInfo from './ArticleInfo.vue' </script>

步骤3：修改src\main.js文件，切换页面中显示的组件。

import App from './components/MyArticle.vue'

保存上述代码后，在浏览器中访问，使用具名插槽的页面效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps27.jpg) 

***\*6.1.2 作用域插槽\****

一般情况下，在父组件中不能使用子组件中定义的数据。如果想要在父组件中使用子组件中定义的数据，则需要通过作用域插槽来实现。作用域插槽是带有数据的插槽，子组件提供一部分数据给插槽，父组件接收子组件的数据进行页面渲染。

作用域插槽的使用分为定义数据和接收数据两个部分。

***\*1\**** ***\*定义数据\****

在封装组件的过程中，可以为预留的插槽定义数据，供父组件接收并使用子组件中的数据。在作用域插槽中，可以将数据以类似传递props属性的形式添加到<slot>标签上。

例如，在封装MyHeader组件时，在插槽中定义数据供父组件使用，示例代码如下。

<slot message="Hello Vue.js"></slot>

***\*2 接收数据\****

使用默认插槽和具名插槽接收数据的方式不同，接下来分别进行讲解。

**1)** ***\*默认插槽\****

在Vue中，每个插槽都有name属性，表示插槽的名称。在定义插槽时虽然省略了<slot>标签的name属性，但是name属性默认为default，这样的插槽属于默认插槽。

在父组件中可以通过v-slot指令接收插槽中定义的数据，即接收作用域插槽对外提供的数据。通过v-slot指令接收到的数据可以在插槽内通过Mustache语法进行访问。

例如，在父组件中使用MyHeader组件中的插槽时，通过v-slot指令的值接收传递的数据的示例代码如下。

<MyHeader v-slot="scope"> <p>{{ scope.message }}</p></MyHeader>

通过v-slot接收从作用域插槽中传递的数据，scope为形参，表示从作用域插槽中接收的数据，该形参的名称可以自定义。

作用域插槽对外提供的数据对象可以使用解构赋值以简化数据的接收过程，示例代码如下。

<MyHeader v-slot="{ message }"> <p>{{ message }}</p></MyHeader>

通过解构赋值解构对象，解构后子组件中定义的数据可以直接访问，而不是以“形参.属性”的方式访问。

**2)** ***\*具名插槽\****

在Vue中，通过<slot>标签添加name属性来定义具名插槽，在具名插槽中也可以向父组件中传递数据。

例如，在封装MyHeader组件时，向具名插槽中传入数据的语法格式如下。

<slot name="header" message="hello"></slot>

具名插槽和作用域插槽可以作用在同一个<slot>标签上且并不冲突。<slot>标签的name属性不会作为数据传递给插槽，所以最终传递给组件的数据只有message属性。

在使用具名插槽时，插槽属性可以作为v-slot的值被访问到，基本语法格式为“v-slot:插槽名称="形参"”，简写形式为“#插槽名称="形参"”，使用简写形式使用插槽的示例代码如下。

<MyHeader> <template #header="{ message }">  {{ message }} </template></MyHeader>

如果在一个组件中同时定义了默认插槽和具名插槽，并且它们均需要为父组件提供数据，这时就需要为默认插槽使用显式的<template>标签来接收数据，示例代码如下。

<MyHeader> <template #default="{ message }">  {{ message }} </template></MyHeader>

**3)** ***\*作用域插槽的使用：\****

步骤1：创建src\components\SubScopeSlot.vue文件，用于展示作用域插槽

<template> <slot message="Hello 默认插槽"></slot> <hr> <slot message="Hello Vue.js" name="header"></slot> <hr> <slot :user="user" name="content"></slot></template><script setup>import { reactive } from 'vue'const user = reactive({ name: 'xiaoyuan', age: '15' })   </script>

步骤2：创建src\components\ScopeSlot.vue文件，用于为作用域插槽提供数据

<template> <SubScopeSlot>  <template v-slot:default="scope"><p>{{ scope }}</p></template>  <template v-slot:header="scope">   <p>{{ scope }}</p><p>{{ scope.message }}</p>  </template>  <template #content="{ user }">   <p>{{ user.name }}</p><p>{{ user.age }}</p></template> </SubScopeSlot></template><script setup>import SubScopeSlot from './SubScopeSlot.vue'</script>

步骤3：修改src\main.ts文件，切换页面中显示的组件。

import App from './components/ScopeSlot.vue'

保存上述代码后，在浏览器中访问，作用域插槽的页面效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps28.jpg) 

***\*3\**** ***\*作用域插槽在三方库组件中的使用\****

在实际开发过程中，插槽的应用场景不仅限于父子组件间的内容传递，它们还可以被用来定制第三方库提供的复杂组件的内容显示方式。例如，在 Element Plus 等 UI 库中，许多组件都预留了插槽接口，允许开发者自定义这些组件的某些部分或增强其功能。

例如我们使用<el-select>和<el-option>的组合制作下拉选项框，并为每个选项通过插槽提供额外的文字描述（如首都、直辖市这些描述）。最终效果如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps29.jpg) 

在 Vue 中，作用域插槽可以通过直接在组件内部使用 <template #slotName="slotProps"> 来定义，在实现上我们将<el-option>中的数据定义成数组，在<el-option>中通过v-for指令循环遍历数据来显示内容。实现代码如下。

<template>

  <div style="padding: 20px;">

  <h4>请选择一个选项：</h4>

  <el-select v-model="selected" placeholder="请选择">

   <el-option

​    v-for="item in options"

​    :key="item.value"

​    :label="item.label"

​    :value="item.value"

   \>

​    <template #default>

​     <span>{{ item.label }}</span>

​     <span style="float:right; color:#8492a6">{{ item.extra }}</span>

​    </template>

   </el-option>

  </el-select>

 </div>

</template>

 

<script setup>

import { ref } from 'vue'

 

const selected = ref('')

const options = [

 { label: '北京', value: 'bj', extra: '首都' },

 { label: '上海', value: 'sh', extra: '直辖市' },

 { label: '广州', value: 'gz', extra: '一线城市' }

]

</script>

代码解释：

 <el-select v-model="selected" placeholder="请选择">v-model="selected"：将选中的值双向绑定到变量 selected 上。

v-for="item in options"：使用 v-for 循环遍历 options 数组，为数组中的每一个对象生成一个 <el-option> 元素。item 是当前循环的数组元素。

:key="item.value"：给每个 <el-option> 设置唯一标识 key，推荐使用数据中唯一且稳定的字段作为 key，这里用的是 item.value。

:label="item.label"：指定该选项在下拉框中显示的文字（如北京、上海）。当选中该项时，el-select 显示的就是这个 label 的值。

:value="item.value"：指定该选项的真实值（如bj、sh）。当选中该项时，v-model="selected" 会把 item.value 赋值给 selected 变量。

<template #default>：定义作用域插槽（默认插槽），允许我们自定义该选项的显示内容。插槽在这里的作用是：告诉 <el-option>，“我想自己控制怎么显示这一项”。 <span>{{ item.label }}</span>：显示主信息，即 label 字段，如“北京”、“上海”等。

<span style="float:right; color:#8492a6">{{ item.extra }}</span>：显示辅助信息，如“首都”、“直辖市”等。

类似的还有<el-table-column>、<el-tabs> 和 <el-tab-pane>的组合都支持用户通过插槽来自定义内容。也就是说插槽是一种模板传递机制，不一定非要父子组件通信才能用，上面的代码而是父组件向第三方组件（如 Element Plus 的组件）传入自定义模板的方式。

 

***\*【任务实施】\****

***\*1.\*******\*修改知识课堂界面\****

打开上一章的nbvueproject项目下的src/components/ExpertList.vue页面，我们需要根据数据源professionaldata中推荐状态和发布状态的数字，用相应的文本代替，并且根据推荐、发布状态动态的设置操作中的显示按钮。其次对于序号列也可以通过插槽来设置序号的自增。

在实现上我们可以定义一个默认插槽，那么在组件中就会将插槽的上下文信息赋值给这个插槽变量，对于表格组件通过变量.row可以访问到当前行的数据对象。

***\*（1）插槽实现序号自增\****

在原来的代码中我们是使用<el-table-column >组件自带的type="index"属性实现的序号自动排列，下面我们再讲如何使用插槽来定义序号数字的自增效果。

Element Plus 的 <el-table> 组件在作用域插槽中提供了一个$index属性，它表示当前行在表格数据数组中的索引值（从0开始）。通过使用作用域插槽，你可以访问到这个 $index 属性，并根据需要进行处理或显示。代码如下

   <el-table-column label="序号" width="60">

   <template #default="scope">

​    {{ scope.$index+1}}

   </template>

  </el-table-column>

\#default="scope"：这里定义了一个默认插槽，并将插槽的上下文信息赋值给了变量 scope。这个上下文通常包含了与当前插槽相关的各种数据。

***\*（2）发布和推荐状态文本显示\****

上面说到在表格组件中，可以通过定义的插槽变量scope.row访问到当前行的所有数据组成的对象。例如，如果有一行数据包含 id, name, status 等字段，则scope.row.id、scope.row.name、scope.row.status 分别对应这些字段的值。

通过获取professionaldata中的status的值，判断其状态是0则显示未发布，1则显示发布。为简化代码行数可通过三元运算符来判断。代码如下：

  <el-table-column label="发布状态" align="center" property="status" >

   <template #default="scope">

​    {{ scope.row.status === 1 ? '已发布' : '未发布'}}

   </template>

  </el-table-column>

  <el-table-column label="是否推荐" align="center" property="isrecommand" >

   <template #default="scope">

​    {{ scope.row.isrecommand === 1 ? '推荐' : '不推荐'}}

   </template>

  </el-table-column>

***\*（3）操作列按钮的动态显示\****

操作列包含编辑、删除、发布、推荐、取消发布、取消推荐按钮，其中编辑、删除按钮是每一行都有的，后4个按钮可通过绑定v-if根据发布状态、是否推荐列的状态来动态显示。

按钮使用<el-button>组件，通过type="text"属性设置文本按钮。代码如下：

<el-table-column label="操作" align="center" width="230">

   <template #default="scope">

​    <el-button

​     type="text"

​     @click="handleUpdate(scope.row)"

​     size="small"

​    \>编辑</el-button>

​    <el-button

​     type="text"

​     @click="handleDelete(scope.row)"

​     size="small"

​    \>删除</el-button>

​    <el-button

​     type="text"

​     v-if="scope.row.status == 0"

​     @click="publish(scope.row)"

​     size="small"

​     \>发布</el-button>

​    <el-button

​     type="text"

​     v-if="scope.row.status == 1"

​     @click="revokePublish(scope.row)"

​     size="small"

​     \>取消发布</el-button>

​    <el-button

​     type="text"

​     v-if="scope.row.isrecommand == 0"

​     @click="recommended(scope.row)"

​     size="small"

​     \>推荐</el-button>

​    <el-button

​     type="text"

​     v-if="scope.row.isrecommand == 1"

​     @click="revokeRecommended(scope.row)"

​     size="small"

​     \>取消推荐</el-button>

   </template>

  </el-table-column> 

启动服务，浏览器运行后的效果如下图所示：

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps30.jpg) 

***\*【任务总结】\****

本次任务我们了解了插槽的概念，在使用插槽过程中，需要注意插槽内容的作用域问题。特别是在具名插槽和作用域插槽中，要确保父组件和子组件之间的数据传递和访问正确无误。同时，对于复杂的组件嵌套结构，合理规划插槽的使用可以避免出现混乱的布局和难以维护的代码。

 

 

***\*6.2 任务二 数据\*******\*请求获取与增删改操作\****

***\*【任务描述】\****

本任务旨在利用 Axios 进行数据请求，并通过 Mock.js 模拟后端接口，实现在页面中展示知识管理专家列表的数据。此外，我们将结合 Element Plus 的 Dialog 组件 实现新增和编辑专家信息的功能，并提供删除、发布及批量发布等操作的完整逻辑。

新增：当点击表格右上方的新增按钮时，会弹出对话框，用于新增用户信息，新增后的数据会显示在表格列中。如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps31.jpg) 

图 新增专家

批量操作：当全选或者选择一条或多条信息，然后点击批量发布、批量推荐等批量按钮时会进行批量操作，如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps32.jpg) 

图 批量操作

 编辑：当点击表格操作列下某一行的编辑按钮时，会弹出对话框，并回显当前专家信息到对话框的输入框中，编辑后的数据会更新到当前行中。如下图所示

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps33.jpg) 

图 编辑专家

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps34.jpg) 

图 编辑后数据更新

 删除：当点击表格操作列下某一行的删除按钮时，会删除当前行数据。

 单条操作：当点击表格操作列下某一行的发布、取消发布、推荐、取消推荐按钮时，会更新当前行的发布状态和是否推荐列的显示信息。

 

***\*【任务分析】\****

**①**　***\*使用 Axios 和 Mock.js 获取数据\****

l 使用 Axios 发起 HTTP 请求以获取数据。

l 利用 Mock.js 模拟后端 API 接口，模拟数据响应，以便在开发环境中测试前端功能而不依赖实际后端服务。

**②**　***\*新增功能逻辑描述\****

l Dialog 组件的复用：新增与编辑功能可共用同一个 <el-dialog> 组件，通过判断变量值是ture或false决定是新增还是编辑状态。

l 触发新增操作：用户点击“新增”按钮，系统弹出一个对话框（Dialog），用于输入新的专家信息。

l 填写信息：在对话框中提供表单，用户可以输入或选择专家的各项信息（如姓名、状态等）。

l 提交保存：用户点击对话框中的“确定”按钮，前端收集表单数据并通过 Axios 发送 POST 请求到后端接口（例如 /api/AddExpert）同时传递该记录的唯一标识符（如 idnum）。

l 后端接收到请求后处理数据，并返回操作结果（成功或失败）。

l 前端根据后端响应更新本地数据源，并重新渲染表格以显示新添加的专家信息。

l 取消操作：如果用户在未保存前点击了对话框中的“取消”按钮，则关闭对话框且不执行任何保存操作。

**③**　***\*编辑功能逻辑描述\****

l 触发编辑操作：用户点击表格中某条记录对应的“编辑”按钮，系统弹出一个预填充了当前记录信息的对话框。

l 修改信息：用户可以在对话框中修改已有的专家信息。

l 提交更新：用户点击对话框中的“确定”按钮，前端收集修改后的表单数据并通过 Axios 发送 POST 请求到后端接口（例如 /api/EditExpert）。

l 后端接收到请求后更新数据库中的对应记录，并返回操作结果。

l 前端根据后端响应更新本地数据源，并重新渲染表格以反映最新的专家信息。

l 取消编辑：若用户在未保存前点击了对话框中的“取消”按钮，则关闭对话框且不执行任何更改。

**④**　***\*删除功能逻辑描述\****

l 触发删除操作：用户点击表格中某条记录对应的“删除”按钮，系统提示用户确认是否要删除该记录。

l 确认删除：用户确认删除后，前端发送 DELETE 请求到后端接口（例如 /api/DeleteExpert），并附带要删除记录的唯一标识符（如 idnum）。

l 后端接收到请求后从数据库中删除指定记录，并返回操作结果。

l 前端根据后端响应更新本地数据源，并重新渲染表格以移除被删除的记录。

**⑤**　***\*批量发布功能逻辑描述\****

l 选择记录：用户通过复选框选择多条需要发布的专家记录。

l 触发批量发布操作：用户点击“批量发布”按钮，前端收集所有选中记录的唯一标识符（如 idnum）。

l 执行批量发布：前端发送 POST 请求到后端接口（例如 /api/BatchPublish），并将所有选中记录的标识符作为参数传递给后端。

l 后端接收到请求后遍历这些标识符，逐一更新对应记录的状态，并返回操作结果。

l 前端根据后端响应更新本地数据源，并重新渲染表格以反映所有被发布的记录的新状态。

 

***\*【知识准备】\****

***\*6.2.1 Axios\*******\*和Mock介绍\****

在Vue项目中结合使用Axios和Mock.js主要是为了模拟后端接口数据，方便前端进行独立开发与测试。这种方式特别适用于前后端分离的开发模式，其中前端可以在没有实际后端服务的情况下先行开发界面和逻辑。

***\*1\**** ***\*Axios的作用\****

Axios是一个基于Promise的HTTP客户端，可以用于浏览器和Node.js进行HTTP请求。它允许你发送异步的HTTP请求从JavaScript代码到远程服务器，并且支持Promise API。在Vue项目中，Axios常用来替代原生的fetch API，因为它提供了更丰富的功能，比如拦截请求和响应、取消请求、转换请求和响应数据等。

当你在Vue项目中集成Axios时，通常会用它来处理真实的API请求，即从前端向后端发起请求并接收响应。这意味着一旦你的后端服务准备好了，你可以直接通过修改Axios请求的基础URL或路径来指向真实的后端API，而不需要改变前端的业务逻辑代码。

***\*2\**** ***\*Mock.js的作用\****

Mock.js是一个用于生成随机数据并拦截Ajax请求的JavaScript库。它主要用于模拟数据，帮助前端工程师在后端接口还未准备好之前就能进行前端页面的开发和调试工作。Mock.js能够根据你预定义的数据模板生成随机数据，还能拦截指定的Ajax请求，返回自定义的响应数据，使得前端可以在没有真实后端服务的情况下正常运行。

***\*3\**** ***\*使用逻辑\****

**①**　***\*定义Mock数据：\****首先，你需要确定哪些API需要被mock。然后，利用Mock.js提供的语法定义这些API的响应数据格式和规则。这一步是在没有真实后端数据的情况下，为前端提供所需的数据结构。

**②**　***\*拦截请求：\****接下来，使用Mock.js拦截匹配的Axios请求。当Axios发起一个请求时，如果这个请求的URL或方法符合你预先设定的mock规则，Mock.js就会拦截这个请求，并返回预先定义好的模拟数据，而不是去请求真实的服务器。

**③**　***\*无缝切换到真实API：\****随着项目的进展，当后端完成了相应的API开发之后，你可以通过简单地调整Axios配置（例如更改基础URL），让Axios直接访问真实的API，而不需要修改任何其他代码。这种做法使得从使用Mock数据过渡到使用真实数据变得非常平滑。

总的来说，Axios负责处理所有的HTTP请求和响应，无论这些请求是发往mock服务器还是真实服务器；而Mock.js则专注于创建和管理模拟数据，以及拦截特定的请求以返回这些模拟数据，从而支持前端开发过程中的独立性。两者结合使用，可以大大提高开发效率和灵活性。

***\*6.2.1 Axios\*******\*安装与使用\****

***\*1\**** ***\*Axios\*******\*安装\****

Axios的安装方式主要有两种，一种是通过标签引入，另一种是使用包管理工具安装。 

**(1)** ***\*通过标签引入\****

使用Unpkg或jsDelivr的内容分发网络服务提供的Axios文件，也可以将Axios文件下载至本地再引入。

① 使用Unpkg的CDN服务引入Axios。

<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

② 使用jsDelivr的CDN服务引入Axios。

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

大家也可以从Axios官方网站中直接下载Axios，下载后再将文件引入网页。因为需要将文件下载到本地，所以不需要考虑无网络的情况。

**(2)** ***\*使用包管理工具安装\****

使用npm或yarn包管理工具安装Axios。

# 使用npm包管理工具安装npm install axios --save# 使用yarn包管理工具安装yarn add axios --save

**(3)** ***\*在Vue 3项目中使用\*******\*npm\*******\*安装Axios\****

步骤1：打开命令提示符，切换到D:\vue\chapter03目录，使用npm创建一个名称为my-axios的项目。在命令提示符中，cd my-axios切换到my-axios目录，为项目安装所有依赖。

步骤2：在my-axios目录下使用npm安装Axios，这里是安装了指定版本Axios，也可以不指定版本号。

npm install axios@1.2.1 --save

***\*2 Axios的使用\****

首先，在vue组件中导入模块，例如在src\App.vue文件中导入模块

import axios from 'axios'

Axios常用的请求方式：get请求和post请求。以get方式为例，其基本语法格式如下：

axios.get('/api/data', {参数}).then(res => {  console.log(res) }).catch(error => {  console.log(error) })

***\*6.2.3 mock.js安装与使用\****

为了方便演示，使用mockjs模拟后端接口，下面讲解如何安装mockjs，以及编写模拟数据和配置模拟数据的相关信息。

示例：有一个书籍信息的json文件，通过Axios发起网络请求，Mock.js拦截请求并返回假数据，将数据在vue组件中显示出来。

***\*（1）Mock.js 安装\****

在my-axios目录下，安装mockjs

//使用npm安装npm install mockjs //使用yarn安装yarn add mockjs@1.1.0 --save

***\*（2）模拟数据开发\****

步骤1：创建模拟数据文件（数据模板），在src/mock目录下新建books.json，定义书籍信息数据。

[ {  "id": 1,  "name": "西游记",  "author": "吴承恩" }, {  "id": 2,  "name": "红楼梦",  "author": "曹雪芹" }, {  "id": 3,  "name": "三国演义",  "author": "罗贯中" }, {  "id": 4,  "name": "水浒传",  "author": "施耐庵" }]

步骤2：配置请求拦截器，在src/mock目录下新建mockServer.ts，编写拦截规则：

Mock.mock() 方法参数：

第1参数：拦截的URL地址 /api/books

第2参数：HTTP方法 get

第3参数：响应模板

当检测到匹配的请求时，自动返回包装后的数据。

import Mock from 'mockjs'import bookData from './books.json' // 导入模拟数据 // 关键：拦截指定URL和请求方法，返回自定义响应Mock.mock( '/api/books', // 拦截的URL（需与Axios请求的URL一致） 'get',    // 拦截的请求方法 {  code: 200,      // 模拟响应状态码  message: 'success', // 模拟提示信息  data: bookData    // 实际返回的业务数据 })

步骤3：激活 Mock 功能（在项目入口引入），修改src/main.ts，在创建 Vue 实例前导入拦截配置：

import { createApp } from 'vue'import App from './main.vue' // 重点：这里先加载Mock配置，确保请求拦截生效// 注意：实际项目需添加环境判断（如仅开发环境启用Mock）import './mock/mockServer' createApp(App).mount('#app')

 这里通过import './mock/mockServer'无条件导入Mock配置，使所有环境都会启用Mock（实际项目应做环境判断）。

**（3）*****\*Vue 组件实战：调用模拟接口并渲染数据\****

 在src目录下新建main.vue，并编写组件代码：

<template>

    <div id="app">

   <h1>四大名著</h1>

   <ul v-if="books.length">

​    <li v-for="book in books" :key="book.id">

​     {{ book.name }} - {{ book.author }}

​    </li>

   </ul>

      <p v-else>加载中...</p>

  </div>

</template>

 

<script setup lang="ts">

 import { ref, onMounted } from 'vue'

 import axios from 'axios'

 

 interface Book {

  id: number;

  name: string;

  author: string;

 }

 

 // 定义响应式数据

 const books = ref<Book[]>([])

 // 请求方法

 const fetchBooks = async () => {

  try {

   const res = await axios.get<{ code: number, data: Book[], message: string }>('/api/books') // 发起请求

   if (res.data.code === 200) {

​    books.value = res.data.data  // 数据绑定

   }

  } catch (error) {

   console.error('请求失败:', error)

  }

 }

 

// 生命周期钩子

onMounted(() => {

 fetchBooks()  // 组件挂载后自动加载数据

})

</script>

<style scoped>

 \#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;

  padding: 20px;

 } 

 ul {

  list-style-type: none;

  padding-left: 0;

 } 

 li {

  margin-bottom: 10px;

 }

</style>

上面代码中的onMounted(() => { fetchBooks() })，是使用了生命周期钩子函数mounted。这意味着一旦组件被挂载到页面上，就会立即调用fetchBooks()函数，从而发起网络请求获取数据。

启动服务，浏览器运行效果如下图所示：

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps35.jpg) 

***\*总结\****

整个流程通过组件、Axios 实例、Mock 服务的交互，实现了从请求发起到数据展示的完整过程。执行流程图如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps36.jpg) 

①　组件初始化触发请求：当页面加载时，组件的 onMounted 钩子自动触发（对应图中 “组件” 发起动作），此时组件通过 Axios 实例向 /api/books 发出 GET 请求。

②　请求被拦截：Mock.js 监测到匹配的请求（图中 “请求被拦截”），立即捕获该请求，不让其访问真实服务器。

③　返回模拟数据：Mock.js 将预定义的模拟数据返回给 Axios 实例（图中 “返回模拟数据”）。

④　组件接收响应：Axios 通过 Promise 将响应数据返回给组件，组件将数据赋值给响应式变量 books（图中 “更新响应式数据”）

⑤　视图更新与页面渲染：。Vue 自动检测到 books 的变化，触发视图更新，重新渲染 DOM，最终用户看到包含图书信息的列表（文字 “页面渲染”）。

简单来说，就是组件想拿数据，Axios 帮忙发请求，但被 Mock 中途拦截并“伪造”了数据回来，最后组件拿到“伪造”数据并显示。

***\*【\*******\*知识拓展\*******\*】\*******\*组件生命周期钩子函数\****

在Vue.js中，组件的生命周期指的是组件从创建到销毁的整个过程。这个过程中有许多关键的时间点，Vue允许我们在这些时间点上执行特定的代码，这些特定的时间点就叫做生命周期钩子。理解这些生命周期钩子可以帮助我们更好地控制组件的行为。

***\*1\**** ***\*组件生命周期简介\****

一个组件就像一个人的一生：出生（创建）、成长（更新）、老去（销毁）。在Vue中，组件也有类似的“人生轨迹”。

***\*--\*******\*创建阶段\****：这是组件被初始化的阶段，包括设置数据观测(data observer)、编译模板、将实例挂载到DOM以及数据变化侦听等。

***\*--\*******\*挂载阶段：\****当组件被插入到DOM中的时候，会经历这一阶段。在这个阶段，我们可以做一些操作比如获取远程数据等。

***\*--\*******\*更新阶段：\****当组件的数据发生变化时，组件会重新渲染，这时就会进入更新阶段。可以利用这个阶段来处理一些需要在DOM更新前后的逻辑。

***\*--\*******\*销毁阶段：\****当组件被移除的时候，它会进入销毁阶段。这里可以做一些清理工作，比如清除定时器、取消网络请求等。

***\*2\**** ***\*生命周期钩子函数介绍\****

每个阶段都有相应的钩子函数，让我们可以在特定的时间点执行代码：

***\*beforeCreate:\**** 在实例初始化之后，数据观测(data observer)和event/watcher事件配置之前被调用。

***\*created:\**** 实例已经创建完成之后被调用。在这一步，实例已完成以下的配置：数据观测(data observer)，属性和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，$el 属性目前不可见。

***\*beforeMount:\**** 在挂载开始之前被调用：相关的 render 函数首次被调用。

***\*mounted: el\**** 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子。此时，组件已经挂载到了DOM上，可以进行DOM操作了。

***\*beforeUpdate:\**** 数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。

***\*updated:\**** 由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。此时，组件 DOM 已经更新，可以执行依赖于 DOM 的操作。

***\*beforeDestroy:\**** 实例销毁之前调用。在这一步，实例仍然完全可用。

***\*destroyed:\**** Vue 实例销毁后调用。调用后，所有的事件监听器会被移除，所有的子实例也会被销毁。

通过理解和使用这些生命周期钩子，你可以更精确地控制你的Vue组件的行为，确保它们在正确的时机执行必要的操作。

 

***\*6.2.5 Dialog组件\****

Dialog组件是一种用户界面元素，通常用于显示模态对话框或弹出窗口，以展示重要信息、提示、确认、表单填写或其他互动内容。这种组件提供了一种方式来引导用户的注意力，以进行特定任务或获取用户的响应。

常用属性及其描述如下表：

| ***\*属性名\****      | ***\*描述\****                                            |
| --------------------- | --------------------------------------------------------- |
| visible               | 控制对话框的显示与隐藏，可以使用.sync修饰符实现双向绑定。 |
| title                 | 对话框标题。                                              |
| width                 | 对话框宽度。                                              |
| top                   | 对话框距离顶部的距离。                                    |
| modal                 | 是否显示遮罩层。                                          |
| modal-append-to-body  | 遮罩层是否插入至 body 元素上。                            |
| close-on-click-modal  | 是否点击遮罩层关闭对话框。                                |
| close-on-press-escape | 是否按下 ESC 键关闭对话框                                 |

下面我们来实现一个可交互的对话框功能，点击按钮弹出对话框，点击“取消”或“确认”可以关闭对话框，且在关闭前会通过二次确认来防止误操作。

步骤1：新建src/componment/Dialog.vue组件

<template>  <!-- 绑定点击事件，当用户点击按钮时，将 dialogVisible 设置为 true，用于显示对话框。 --> <el-button plain @click="dialogVisible = true">    Click to open the Dialog </el-button>  <!-- v-model="dialogVisible">：用于双向绑定控制对话框是否显示。当值为 true 时显示，为 false 时不显示。 title设置对话框标题。  :before-close="handleClose"：在用户尝试关闭对话框前调用 handleClose 函数，用于确认是否真的要关闭。 --> <el-dialog  v-model="dialogVisible"  title="Tips"  width="500"  :before-close="handleClose" >  <span>This is a message</span>   <!-- 使用具名插槽 footer 来自定义底部内容（默认是“取消”和“确定”按钮） -->  <template #footer>   <div class="dialog-footer">    <!-- Cancel：点击后将 dialogVisible 设为 false，即关闭对话框。     Confirm：同样是点击后关闭对话框，只是样式更突出（type="primary" 表示主按钮）。 -->    <el-button @click="dialogVisible = false">Cancel</el-button>    <el-button type="primary" @click="dialogVisible = false">Confirm</el-button>   </div>  </template> </el-dialog></template> <script lang="ts" setup>import { ref } from 'vue'import { ElMessageBox } from 'element-plus' // 创建一个响应式变量 dialogVisible，初始值为 false，表示对话框默认不显示。// 当它变为 true 时，对话框会弹出；变为 false 时关闭。const dialogVisible = ref(false) // 定义一个函数 handleClose，它接收一个参数 done，是一个函数。// 这个函数会在用户尝试关闭对话框时被调用（通过 before-close 属性）。const handleClose = (done: () => void) => { ElMessageBox.confirm('Are you sure to close this dialog?')  .then(() => {   done()  })  .catch(() => {   // catch error  })}</script>

步骤2：修改src/main.ts文件

import App from './components/dialog.vue'

保存代码运行效果，即点击按钮弹出对话框。如下图所示

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps37.jpg) 

当点击“×”关闭对话框时会弹出询问框，点击“ok”才能关闭对话框。如下图所示

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps38.jpg) 

***\*【任务实施】\****

***\*1.Axios数据请求\****

步骤1：切换项目路径下，安装axios和mockjs，命令如下：

npm install axios@1.2.1 --savenpm install mockjs

步骤2：删除ExpertList.vue中的数据源professionaldata，创建src\mock\ExpertList.json文件，该文件用于存放模拟的数据。

 [  { "idnum": 0, "name": "王德发", "introduce": "1990 年，大四的雷军联合王全国、...", "field": "无", "time": "2000-3-15", "status": 0, "isrecommand": 1 },  { "idnum": 1, "name": "李丽", "introduce": "1990 年，大四的雷军联合王全国、...", "field": "无", "time": "2002-4-15", "status": 0, "isrecommand": 1 },  { "idnum": 2, "name": "王小圆", "introduce": "1990 年，大四的雷军联合王全国、...", "field": "无", "time": "2021-5-15", "status": 1, "isrecommand": 1 },  { "idnum": 3, "name": "张红", "introduce": "1990 年，大四的雷军联合王全国、...", "field": "无", "time": "2020-3-17", "status": 0, "isrecommand": 0 }]

步骤3：编写拦截规则，创建src\mock\mockServer.ts文件，该文件用于配置模拟数据的相关信息。

import Mock from 'mockjs';

import expertList from './ExpertList.json';

 

 

Mock.mock('/api/ExpertList', 'get', {

 code: 200,

 message: 'success',

 data: expertList

});

步骤4：修改main.ts文件，引入

import './mock/mockServer.ts'

 步骤5：实现axios请求，定义src/view/ExpertList.vue组件中请求接口和数据绑定。主要修改script中的代码。

<script setup>

 import { ref, onMounted, reactive } from 'vue';

import axios from 'axios'

 

 const form = reactive({

  expertName: '',

  expertField: '',

  recommended: '',

  publishTime: null,

  publishStatus: ''

 });

 

 const onSearch = () => {

  console.log('Form Data:', form);

 };

 

 const onReset = () => {

  // 清空表单数据

  Object.keys(form).forEach(key => {

   form[key] = '';

  });

 };

 

  // 表格数据源

 const professionaldata = ref([])

 //  请求方法

 const fetchExpertData = async () => {

 try {

  const res = await axios.get('/api/ExpertList') // 发起请求

  if (res.data.code === 200) {

  professionaldata.value = res.data.data  // 数据绑定

  }

 } catch (error) {

  console.error('请求失败:', error)

 }

 }

 

// 生命周期钩子

onMounted(() => {

 fetchExpertData() // 组件挂载后自动加载数据

})

 

</script>

 启动服务运行后的效果如下图所示，此时的数据用的是mock中的数据。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps39.jpg) 

 

***\*2.增删改逻辑实现\****

在专家信息管理系统中，新增和编辑专家信息是两个核心操作。这两个操作虽然有不同的用户场景，但共享大部分技术实现逻辑，因此在设计时采用了统一的对话框组件来处理这两种操作。

以新增为例，用户交互流程如下：

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps40.jpg) 

**（1）*****\*Dialog组件设置弹出框\****

 我们先来设计弹出框的界面内容和UI效果，如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps41.jpg) 

 整体设计思路如下：

①　对话框容器：使用 <el-dialog> 组件作为弹出对话框的基础容器。

②　标题动态显示：通过 title 属性和三元运算符动态设置对话框标题，区分是新增还是编辑操作。

③　表单结构：使用 <el-form> 包裹整个表单，并绑定数据源 dialogForm 来存储当前编辑或新增的专家信息。

④　字段输入控件选择：为不同的字段选择合适的输入控件，确保用户输入便捷且准确。

⑤　交互按钮：提供“确定”和“取消”按钮，分别用于提交更改或关闭对话框而不保存任何更改。

在ExpertList.vue中表格组件的结束标签下编写对话框的内容，实现如下：

**l** ***\*对话框容器\****

 使用 <el-dialog> 组件作为弹出对话框的基础容器。标题通过 title 属性结合三元运算符动态显示，依据 isEdit 的值（true 或 false）来判断用户点击的是“编辑”还是“新增”按钮，并相应地设置对话框标题为“编辑专家”或“新增专家”。对话框的可见性状态使用v-model绑定，控制对话框的显示与隐藏。

<el-dialog  :title="isEdit ? '编辑专家' : '新增专家'"  v-model="dialogVisible" width="50%">

**l** ***\*表单结构\****

 内部使用 <el-form> 包裹整个表单，并使用 :model 绑定数据源 dialogForm，用于存储当前编辑或新增的专家信息，确保用户在对话框中所做的任何更改都能实时反映在数据模型中。

<el-form  ref="formRef"  :model="dialogForm"  label-width="100px">

**l** ***\*字段输入控件选择\****

针对不同的字段类型选择合适的输入控件：

专家名称: 使用 <el-input> 实现单行文本输入。

专家简介: 使用 <el-input type="textarea"> 实现多行文本输入。

所属领域: 使用 <el-select> 提供下拉选项，便于用户选择固定选项。

发布状态 和 是否推荐: 使用 <el-radio-group> 实现二选一的互斥选择。

   <el-form-item label="专家名称">

​    <el-input v-model="dialogForm.name" />

   </el-form-item>

   <el-form-item label="专家简介">

​    <el-input v-model="dialogForm.introduce" type="textarea" :rows="4" />

   </el-form-item>

   <el-form-item label="所属领域">

​    <el-select v-model="dialogForm.field" placeholder="请选择">

​     <el-option label="领域一" value="领域一" />

​     <el-option label="领域二" value="领域二" />

​    </el-select>

   </el-form-item>

   <el-form-item label="发布状态">

​    <el-radio-group v-model="dialogForm.status">

​     <el-radio :label="1">已发布</el-radio>

​     <el-radio :label="0">未发布</el-radio>

​    </el-radio-group>

   </el-form-item>

   <el-form-item label="是否推荐">

​    <el-radio-group v-model="dialogForm.isrecommand">

​     <el-radio :label="1">推荐</el-radio>

​     <el-radio :label="0">不推荐</el-radio>

​    </el-radio-group>

   </el-form-item>

**l** ***\*交互按钮\****

 提供“确定”和“取消”按钮，分别用于提交更改或关闭对话框而不保存任何更改。“确定”按钮触发 submitDialog 方法，该方法会根据 isEdit 的值判断是执行更新操作还是新增操作；“取消”按钮简单地将 dialogVisible 设置为 false 来关闭对话框。

<el-form-item>

 <el-button type="primary" @click="submitDialog">确定</el-button>

 <el-button @click="dialogVisible = false">取消</el-button>

</el-form-item>

**（2）*****\*功能实现逻辑\****

**1)** ***\*状态管理设计\****

在script中，首先定义几个关键状态变量：

const professionaldata = ref([])  // 表格数据源

const dialogVisible = ref(false)  // 控制对话框显示隐藏 

const isEdit = ref(false)    // 标识当前是编辑还是新增操作

const dialogForm = ref({})    // 存储表单数据

l dialogVisible: 控制对话框是否显示，初始化为 false 表示对话框默认是关闭的。

l isEdit: 判断当前是编辑模式还是新增模式，初始化为 false 表示默认是新增模式。

l dialogForm: 保存当前对话框中的表单数据，初始化为空对象。

**2)** ***\*新增功能逻辑\****

**①**　***\*触发新增操作\****

当用户点击“新增”按钮时，需要初始化表单数据dialogForm为一个空对象，设置isEdit为false表示当前处于新增模式，将dialogVisible设为true以显示对话框，以此来准备让用户输入新专家的信息。

const handleAdd = () => {

 dialogForm.value = {

  name: '', // 专家名称

  introduce: '', // 专家简介

  field: '', // 所属领域

  status: 0, // 发布状态，默认未发布

  isrecommand: 0, // 是否推荐，默认不推荐

  time: new Date() // 使用当前时间作为默认发布时间

 }

 isEdit.value = false // 设置为非编辑模式

 dialogVisible.value = true // 显示对话框

}

**②**　***\*表单提交\****

在用户完成信息输入并点击“确定”后，执行新增逻辑。在submitDialog 方法中检查是否是新增模式(!isEdit.value)。使用axios.post向'/api/AddExpert'发送请求。请求成功后调用fetchExpertData()刷新表格数据并关闭对话框。

const submitDialog = () => {

 if (!isEdit.value) { // 如果是新增模式

  axios.post('/api/AddExpert', dialogForm.value).then(() => {

   fetchExpertData() // 成功后刷新表格数据

   dialogVisible.value = false // 关闭对话框

  })

 } else {

  // 编辑逻辑见下文

 }

}

参数说明

url: 'api/AddExpert' 是请求的路径，指向后端处理新增专家信息的接口。

data: { dialogForm.value } 是要发送的数据对象，包含了用户在对话框中填写的所有专家信息。这些信息会被序列化并作为请求体的一部分发送到服务器。

 

***\*这里\*******\*为什么使用 POST 请求\*******\*呢\*******\*？\****

l 语义正确：POST 请求通常用于提交数据给服务器，特别是当操作会导致服务器端状态改变时（例如添加新记录）。在这种情况下，使用 POST 请求来提交新的专家信息是符合 RESTful API 设计原则的。

l 安全性：虽然 GET 请求也可以携带参数，但它们会显示在 URL 中，这对于敏感信息来说并不安全。而 POST 请求通过请求体传输数据，不会暴露在 URL 中，因此更加安全。

l 数据量限制：GET 请求的数据长度受限于浏览器和服务器对 URL 长度的限制，而 POST 请求没有这种限制，可以传输更多的数据。

**③**　***\*Mock.js 模拟后端接口\****

为了方便开发，在没有实际后端服务的情况下，使用Mock.js来模拟后端API的行为。打开mockServer.ts编写新增专家接口模拟。

首先，接收前端传来的新增专家数据，解析请求体。自动添加当前时间作为发布的时间戳。将新数据加入到模拟的专家列表中，返回状态码表示操作成功。

// 确保 idnum 是 number 类型，并赋初始值

let currentId = expertList.length;

 

Mock.mock('/api/AddExpert', 'post', (options:any) => {

 const data = JSON.parse(options.body); // 解析请求体

data.idnum = currentId++; // 自动生成唯一 idnum

 data.time = new Date().toLocaleString(); // 将当前时间以本地化字符串格式赋值给 data.time，作为编辑操作的时间戳。

 expertList.push(data); // 将新数据添加到模拟的专家列表中

 return { code: 200 }; // 返回成功状态码

});

在 Mock.js 的接口定义中，当你定义一个接口如：Mock.mock('/api/AddExpert', 'post', (options) => {})，Mock.js 在拦截到 POST 请求时，会将整个请求的信息封装成一个对象传入回调函数，这个对象就是 options，通常包含以下常用属性：

| ***\*属性名\**** | ***\*含义说明\****            |
| ---------------- | ----------------------------- |
| url              | 请求地址                      |
| type / method    | 请求方法（GET、POST 等）      |
| body             | 请求体（POST 请求携带的数据） |
| headers          | 请求头信息                    |

所以，在 POST 请求中，前端通过 axios.post(url, data) 发送的数据，会被封装在 options.body 中。

为什么要解析 options.body？因为 options.body 是一个字符串形式的 JSON 数据，而不是 JavaScript 对象，所以必须使用 JSON.parse() 将其转换为对象才能操作。

例如，前端发送的请求体可能是这样的：

{  "name": "张三",  "introduce": "人工智能专家",  "field": "人工智能"}

当它到达 Mock.js 接口时，是作为字符串存在的：

options.body = '{"name":"张三","introduce":"人工智能专家","field":"人工智能"}'

所以要使用const data = JSON.parse(options.body);来解析，解析后得到的就是可以操作的对象：

data = {  name: "张三",  introduce: "人工智能专家",  field: "人工智能"}

 

在解析完成后将新数据添加到模拟的专家列表中，新增操作完成后，前端会调用 fetchExpertData() 函数来重新加载最新的专家列表。此时我们在浏览器中点击新增按钮，在弹出框中输入专家信息并点击确定，在表格中就会看到新增的信息。如下图所示。

![img](file:///C:\Users\高旋\AppData\Local\Temp\ksohtml26216\wps42.jpg) 

 对于上面的新增数据，当我们刷新浏览器后，新增的数据会在表格中消失。打开项目中的ExpertList.json文件，我们会发现新增的数据也并没有更新到该json文件中，这与Mock.js 的工作方式及其与外部文件（如 expertList.json）之间的关系有关，主要原因如下：

**l** ***\*Mock.js 是前端模拟工具\****：它的主要功能是拦截 AJAX 请求并返回预定义的响应数据。它不直接支持文件系统操作，这意味着无法直接读取或写入本地文件（例如 expertList.json）。

**l** ***\*数据存储在内存中\****：在上面的代码示例中，expertList 是一个 JavaScript 数组，用于临时存储专家信息。当您通过 POST 请求向 /api/AddExpert 发送数据时，这些数据被追加到 expertList 中，但并没有机制将这些更改同步回 expertList.json 文件。

**l** ***\*缺乏持久化逻辑\****：要实现对 expertList.json 文件的写入，需要引入额外的逻辑来处理文件系统的读写操作。然而，这超出了 Mock.js 的能力范围，通常需要借助服务器端技术（如 Node.js）来完成。

 

**3)** ***\*编辑功能逻辑\****

**①**　***\*准备编辑数据\****

当用户点击某行的"编辑"按钮时，需要将该行数据复制到对话框表单中，并进入编辑模式。将传入的row（即当前行数据）复制到dialogForm。设置isEdit为true表示当前处于编辑模式。显示对话框以便用户可以编辑数据。

const handleUpdate = (row) => {

 dialogForm.value = { 

  ...row,  // 复制当前行数据到表单

  time: new Date() // 使用当前时间作为默认发布时间

  } 

 isEdit.value = true // 设置为编辑模式

 dialogVisible.value = true // 显示对话框

}

上面代码中的“...row”使用的是 JavaScript 的扩展运算符。扩展运算符是 ES6（ECMAScript 2015）引入的一种语法特性，它允许一个表达式在需要多个参数（用于函数调用）或多个元素（用于数组字面量）或多个键值对（用于对象字面量）的场合展开。

这里的 ...row 被用来将 row 对象的所有可枚举属性“展开”为一个新的对象 dialogForm.value 的属性。简单来说，这行代码的作用是创建 row 对象的一个浅拷贝，并将其赋值给 dialogForm.value。

在这个场景下，我们通常希望编辑操作不会直接影响原始数据，直到用户明确提交更改。通过创建一个浅拷贝，我们可以避免直接修改 row 数据源，除非用户点击了确定按钮并成功更新了后端数据。

**②**　***\*提交编辑结果\****

 用户修改完信息并点击"确定"后，执行更新操作，检查是否是编辑模式(isEdit.value)。使用axios.post向'/api/EditExpert'发送请求。请求成功后调用fetchExpertData()刷新表格数据并关闭对话框。

const submitDialog = () => {

 if (!isEdit.value) { // 如果是新增模式

  ......

 } else {

  // 编辑逻辑

  axios.post('/api/EditExpert', dialogForm.value).then(() => {

   fetchExpertData() // 成功后刷新表格数据

   dialogVisible.value = false // 关闭对话框

  })

 }

}

 

**③**　***\*Mock.js 模拟后端接口\****

打开mockServer.ts编辑专家接口模拟，从请求体中提取数据并解析为 JS 对象。根据idnum查找要编辑的专家在数组中的位置。然后使用splice()方法替换原数据。

Mock.mock('/api/EditExpert', 'post', (options:any) => {

 const data = JSON.parse(options.body); // 解析请求体

data.time = new Date().toLocaleString(); // 添加当前时间为发布时间

 const index = expertList.findIndex(i => i.idnum === data.idnum); // 查找要编辑的专家索引

 if (index > -1) {

  expertList.splice(index, 1, data); // 替换旧数据

 }

 return { code: 200 }; // 返回成功状态码

});

这里使用 findIndex 方法遍历 expertList 数组，找到第一个满足条件（即 i.idnum === data.idnum）的元素，并返回其索引。如果找不到匹配项，则返回 -1。

如果找到了匹配项（即 index > -1），则使用 splice 方法从 expertList 中删除原有的专家记录，并插入新的 data 对象来替换它。

**4)** ***\*删除功能逻辑\****

删除操作的逻辑如下：

①　触发删除操作：当用户选择删除某个专家时（例如点击“删除”按钮），前端会调用 handleDelete 函数。

②　发送请求到服务器：handleDelete 函数通过POST请求将被删除专家的唯一标识符（如 idnum）发送给后端接口 /api/DeleteExpert。

③　处理删除请求：后端接收到请求后，根据传递过来的 idnum 查找并从数据expertList中移除对应的专家记录。

④　更新前端展示的数据：删除成功后，前端重新获取最新的专家列表，并更新页面显示以反映当前的状态。

具体实现如下：

**1)** ***\*定义前端删除函数\****

打开ExpertList.vue继续编写删除操作的触发事件。该函数接收要删除的专家记录作为参数（通常是从表格行中传递过来的）。使用 Axios 发送 POST 请求到 /api/DeleteExpert 接口，同时传递专家的唯一标识符 idnum。

const handleDelete = (row) => {

 axios.post('/api/DeleteExpert', { id: row.idnum }).then(() => {

  fetchExpertData();

 });

};

**2)** ***\*模拟后端处理删除请求\****

在 mockServer.js 中定义 /api/DeleteExpert 路由，用于模拟后端处理删除请求的过程。解析传入的请求体，从中提取出 id（即 idnum）。使用 findIndex 方法在 expertList 中查找具有相同 idnum 的专家记录。如果找到了匹配项，则使用 splice 方法将其从 expertList 中移除。

Mock.mock('/api/DeleteExpert', 'post', (options: any) => {

 const { id } = JSON.parse(options.body);

 const index = expertList.findIndex(i => i.idnum === id);

 if (index > -1) {

  expertList.splice(index, 1); // 从列表中移除该项

 }

 return { code: 200 };

});

启动服务，点击删除按钮即可删除当前行。

 

***\*3.发布、推荐实现\****

发布、推荐这些功能分为两类：

| ***\*类型\**** | ***\*功能\****                                 | ***\*说明\****                           |
| -------------- | ---------------------------------------------- | ---------------------------------------- |
| 单条操作       | 发布、取消发布、推荐、取消推荐                 | 针对某一行数据（如点击“发布”按钮）       |
| 批量操作       | 批量取消发布、批量取消推荐、批量发布、批量推荐 | 针对多行数据（如勾选多个专家后统一操作） |

对应的函数和请求接口如下：

| ***\*操作类型\****     | ***\*函数名\**** | ***\*修改字段\****    | ***\*请求接口\**** | ***\*用途\**** |
| ---------------------- | ---------------- | --------------------- | ------------------ | -------------- |
| 单条操作               | publish          | status = 1            | /api/EditExpert    | 设置为已发布   |
| revokePublish          | status = 0       | /api/EditExpert       | 设置为未发布       |                |
| recommended            | isrecommand = 1  | /api/EditExpert       | 设置为推荐         |                |
| revokeRecommended      | isrecommand = 0  | /api/EditExpert       | 设置为不推荐       |                |
| 批量操作               | batchPublish     | status =1             | /api/BatchPublish  | 批量发布       |
| batchRecommended       | isrecommand = 1  | /api/BatchRecommend   | 批量推荐           |                |
| revokeBatchPublish     | status = 0       | /api/BatchUnPublish   | 批量取消发布       |                |
| revokeBatchRecommended | isrecommand = 0  | /api/BatchUnRecommend | 批量取消推荐       |                |

它们的核心逻辑都是：修改状态字段值、发送请求到服务器、刷新页面数据。

***\*（1）\*******\*单条操作\****

发布、取消发布、推荐、取消推荐的逻辑都相同，我们以发布操作为例来详细介绍下。

发布的作用是将某条专家记录设置为“已发布”，在实现上将传入的专家对象row的status属性设置为 1，表示该专家已被发布，然后使用 Axios 发送 POST 请求到 /api/EditExpert 接口，请求体是修改后的 row 对象，成功后调用 fetchExpertData() 函数刷新数据列表。

const publish = (row) => {

 row.status = 1

 axios.post('/api/EditExpert', row).then(() => fetchExpertData())

}

单条发布的功能已全部实现，大家可根据上面发布的逻辑自行实现单条推荐、取消发布、取消推荐的功能。

***\*（2）批量\*******\*操作\****

批量发布、推荐、取消发布、取消推荐的逻辑也是一样的，我们以批量发布为例阐述其逻辑和实现。

**①**　***\*添加状态监听\****

批量操作是根据用户在前端界面的表格里通过复选框选择一条或多条专家记录，根据复选框的选中状态来决定哪些数据需要批量操作，所以需要为表格添加一个状态监听。Element Plus 库支持通过 <el-table-column type="selection"> 来创建一个选择列，允许用户选择表格中的行。当使用这种配置时，Element Plus 会自动管理选中状态，并在选择发生变化时触发 @selection-change 事件。

<el-table v-loading="loading" :data="professionaldata" @selection-change="handleSelectionChange">

用户选中的每条记录都代表一个专家对象，其中包含该专家的所有信息（如 idnum、name、status 等），所以还需要创建一个数组对象用来存放选中的专家对象。在监听@selection-change 事件时，Element Plus 会自动将当前所有被选中的行（即专家对象）作为一个数组传递给事件处理函数，这个数组就是下面的selection 参数，所以在handleSelectionChange 函数中将选中的对象信息更新到selectedExperts 变量中。

const selectedExperts = ref([]); // 存储选中的专家对象

 

const handleSelectionChange = (selection) => {

 selectedExperts.value = selection; // 更新选中的专家列表

};

**②**　***\*批量发布按钮逻辑\****

将当用户点击“批量发布”按钮，触发 batchPublish 函数。在 batchPublish 函数内部，从这些选中的专家对象中提取出每个专家的唯一标识符 idnum，形成一个数组 ids。

然后使用 Axios 发送 POST 请求到后端接口 /api/BatchPublish，并将刚刚构建好的 ids 数组作为请求体的一部分传递过去。一旦服务器成功处理了请求并返回响应，前端会调用 fetchExpertData() 方法来重新加载最新的专家列表，确保页面显示的是最新的状态。

const batchPublish = () => {

 const ids = selectedExperts.value.map(e => e.idnum)

 axios.post('/api/BatchPublish', { ids }).then(() => {

  fetchExpertData()

 })

}

**③**　***\*后端处理逻辑\*******\*mock\****

在mockServer.ts中，当后端接收到 /api/BatchPublish 接口的请求时，它会解析请求体，从中获取 ids 数组。对于每一个 id 在 ids 数组中，找到对应的专家对象，并将其 status 字段设置为 1，表示该专家已被发布。

完成所有必要的状态更新后，向客户端返回一个成功的响应消息，通常包括状态码和一条简短的消息说明操作结果。

Mock.mock('/api/BatchPublish', 'post', (options:any) => {

 const requestBody = JSON.parse(options.body); // 解析整个请求体

 const ids = requestBody.ids; // 直接获取 ids 数组

 ids.forEach((id:number) => {

  const expert = expertList.find(e => e.idnum === id);

  if (expert) {

   expert.status = 1; // 更新状态为未发布

  }

 });

 

 return { code: 200};

});

至此批量发布的功能已全部实现，大家可根据批量发布的逻辑自行实现批量推荐、取消发布、取消推荐的功能。

 

***\*【任务总结】\****

本次任务我们使用了axios和mock.js对于 mock.js，要注意模拟数据的真实性和合理性，尽量与真实接口返回的数据结构和内容保持一致，以便在切换到真实接口时能够无缝衔接。

此外我们综合使用dialog组件和form表单组件完成新增等功能，需要注意的是新增是分两步完成，点击新增我们是打开对话框，输入内容，点击确定的时候才请求新增接口完成新增功能，并关闭对话框。

***\*6.\*******\*3\**** ***\*任务\*******\*三\**** ***\*知识扩展—状态管理\****

***\*【任务描述】\****

 

***\*【任务\*******\*分析\*******\*】\****

 

***\*【\*******\*知识准备\*******\*】\****

 

***\*【\*******\*任务实施\*******\*】\****

 

 

***\*【项目考核】\****

***\*1\**** ***\*多选题\****

(1) 关于Vue插槽，以下哪些说法正确？

A. 默认插槽无需指定name属性
B. 具名插槽通过v-slot:header或#header使用
C. 作用域插槽允许子组件向父组件传递数据
D. 插槽内容只能是静态文本
解析：D错误，插槽内容可以是动态数据或组件。

(2) 关于 Mock.js 的描述，以下哪些是正确的？

A. Mock.js 可以生成随机数据

B. Mock.js 可以拦截 Ajax 请求

C. Mock.js 只能在开发环境中使用

D. Mock.js 可以帮助前端工程师在没有后端服务的情况下进行开发

答案: A, B, D

解析: C 错误，Mock.js 主要在开发环境中使用，但也可以在生产环境中配置条件性启用

(3) 使用Axios时，以下哪些配置是正确的？

A. axios.get("/api/data", { params: { id: 1 } })

B. axios.post("/api/user", { name: "张三" }, { params: { age: 25 } })

C. 使用拦截器统一添加请求头

D. 通过.catch()处理请求错误
 答案：A、C、D
 解析：B错误，POST请求参数应放在请求体，而非URL参数。

(4) Mock.js的功能包括哪些？

A. 生成随机数据
 B. 拦截Ajax请求
 C. 直接修改本地JSON文件
 D. 模拟接口返回数据
 答案：A、B、D
 解析：C错误，Mock.js无法直接操作本地文件。

(5) 在Element Plus的el-table中，如何通过作用域插槽获取当前行数据？

A. scope.row

B. row.data

C. $index.row

D. slotProps.row
 答案：A
 解析：A正确，scope.row是标准用法。

(6) 组件生命周期钩子onMounted适合执行哪些操作？

A. 初始化表单数据

B. 发送网络请求加载数据

C. 清理定时器

D. 更新DOM元素样式
 答案：A、B
 解析：C应在onBeforeUnmount中处理，D应在onUpdated中处理。

***\*2 问答题\****

(7) 描述Axios和Mock.js是如何工作的。

参考答案：

①　请求发起：组件加载时通过 Axios 向指定接口（如 /api/books）发起 HTTP 请求。

②　拦截与模拟：Mock.js 拦截匹配的请求，根据预设规则生成模拟数据，绕过真实服务器。

③　数据传递：Mock.js 返回的模拟数据由 Axios 接收，并通过 Promise 传递给组件，更新响应式变量（如 books）。

④　视图渲染：Vue 检测到响应式变量变化，自动触发 DOM 重新渲染，用户看到模拟数据构成的页面内容。

 

(8) 在现有项目的基础上，添加一个批量删除按钮，并实现批量删除功能，用户可以选择多条记录并通过点击“批量删除”按钮一次性删除选中的所有记录。

答案：参考批量发布等操作，mock的代码如下

Mock.mock('/api/BatchDelete', 'post', (options:any) => {

 const { ids } = JSON.parse(options.body); // 获取请求体中的 id 列表

 

 // 遍历 ids 数组，从 expertList 中移除对应的专家

 ids.forEach((id:number) => {

  const index = expertList.findIndex(expert => expert.idnum === id);

  if (index !== -1) {

   expertList.splice(index, 1); // 删除对应的专家记录

  }

 });

 

 return { code: 200, message: '删除成功' };

});

 